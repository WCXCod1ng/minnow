#include "tcp_sender.hh"
#include "tcp_config.hh"

#include <iostream>

using namespace std;

uint64_t TCPSender::sequence_numbers_in_flight() const
{
  // Your code here.
  return sequence_numbers_in_flight_;
}

uint64_t TCPSender::consecutive_retransmissions() const
{
  // Your code here.
  return consecutive_retransmissions_;
}

void TCPSender::push( const TransmitFunction& transmit )
{
  // 特殊情况：receiver声称的0-size window的情况，此时应当假设窗口为1
  if(window_size_ == 0) {
    if(!zero_message_sent_) {
      zero_message_sent_ = true;
      // 读取一个字节的内容，这里的seq_len应当是SYN+payload_size+FIN一起总和为1
      const auto sv = input_.reader().peek();
      TCPSenderMessage sender_message;
      sender_message.SYN = next_seqno_ == isn_;
      sender_message.payload = string(sv.substr(0, sender_message.SYN ? 0 : 1));
      input_.reader().pop(sender_message.payload.size());
      sender_message.seqno =next_seqno_;
      sender_message.FIN = sender_message.SYN ? false : sv.empty();
      sender_message.RST = input_.reader().has_error();
      transmit(sender_message);

      // 后更新
      update_after_transmit( sender_message );
    }
    return;
  } else {
    zero_message_sent_ = false;
  }

  // 特殊情况：判断窗口是否full，full意味着不能发送数据
  uint64_t window_available_capacity = window_left_bound_.unwrap(isn_, 0) + window_size_ - next_seqno_.unwrap(isn_, 0);
  if(window_available_capacity == 0) {
    return;
  }

  // 下面是一般情况
  // 读取数据
  const auto s = string(input_.reader().peek());

  // 不应当只是push一次，而是直到window_available_capacity或者遇到FIN为止
  uint64_t cur_begin {0}; // 存储当前string中的起始index
  uint64_t cur_len; // 存储当前要发送的string片段的长度
  do {
    // 直到发送完为止，别忘了要注意特殊情况：即遇到FIN
    // 更新SYN_message_状态，
    SYN_message_ = next_seqno_ == isn_;

    TCPSenderMessage sender_message;
    sender_message.seqno = next_seqno_;
    sender_message.SYN = SYN_message_;
    if(s.size()-cur_begin >= window_available_capacity - SYN_message_) {
      // 本次传送的FIN必须为false，由于window的尺寸的限制，size >= W - SYN，不可能放入FIN了，必须等到下次
      cur_len = min(window_available_capacity - sender_message.SYN, TCPConfig::MAX_PAYLOAD_SIZE); // 注意要去掉SYN，为其留存位置
      sender_message.payload = s.substr(cur_begin, cur_len);
      input_.reader().pop(cur_len);
      sender_message.FIN = false; // 恒定赋值为false
    } else {
      // 否则需要考虑FIN可能为true的情况（且如果为true，必能放入窗口中），此时size <= W - SYN - 1
      cur_len = min(s.size()-cur_begin, TCPConfig::MAX_PAYLOAD_SIZE);
      sender_message.payload = s.substr(cur_begin, cur_len);
      input_.reader().pop(cur_len);
      if(!FIN_ && input_.reader().is_finished()) {
        FIN_ = true;
        sender_message.FIN = true;
      } else {
        sender_message.FIN = false;
      }
    }
    // 综合两种情况
    sender_message.RST = input_.reader().has_error();

    // 特殊情况：如果sequence_lenght() == 0，则不需要发送
    if(sender_message.sequence_length() == 0) {
      return;
    }

    // 调用transmit进行消息发送
    transmit(sender_message);

    // 后处理
    // 更新下一个要发送的seqno
    next_seqno_ = next_seqno_ + sender_message.sequence_length();
    // 送入outstanding_segments_中，由于push的单调性，因此只需要push即可
    outstanding_segments_.emplace_back(sender_message);
    // 更新sequence_numbers_in_flight_的值
    sequence_numbers_in_flight_ = next_seqno_.unwrap( isn_, 0 ) - window_left_bound_.unwrap(isn_, 0);

    // 4. 包含的数据占据了seqno的条件下（实际上不需要）：如果timer not running -> start（设置新的RTO）
    if(sender_message.sequence_length() > 0 && !retransmission_timer_.is_running()) {
      retransmission_timer_.restart( alive_ms_, RTO_ms_ ); // 是restart还是start，或者其他？
    }
    // 更新窗口容量
    window_available_capacity = window_left_bound_.unwrap(isn_, 0) + window_size_ - next_seqno_.unwrap(isn_, 0);

    // 遇到message中FIN的情况，是否要终止？先不终止

    // 更新循环变量
    cur_begin += cur_len;
  } while(cur_begin < s.size());

  // 还要特殊考虑，恰巧s发送完，刚好结束，但是对应的标志位FIN没有发送过去，也即需要单独发送一次，也要保证FIN的大小
  if(cur_begin == s.size() && !FIN_ && input_.reader().is_finished() && window_available_capacity > 0) {
    FIN_ = true;
    TCPSenderMessage sender_message = {.seqno = next_seqno_, .SYN = next_seqno_ == isn_, .payload = "", .FIN = true, .RST = input_.reader().has_error()};
    transmit(sender_message);
    // 后更新
    update_after_transmit( sender_message );
  }
}

TCPSenderMessage TCPSender::make_empty_message() const
{
  // Your code here.
  return { .seqno = next_seqno_,  .SYN = false, .payload = "", .FIN = false, .RST = input_.reader().has_error()};
}

void TCPSender::receive( const TCPReceiverMessage& msg )
{
  // 特殊情况：receiver回复的message包含RST，那么直接退出，并设置流错误。不管ackno是否有效
  if(msg.RST) {
    input_.writer().set_error();
    return;
  }

  // 接受来自receiver的响应结果
  if(!msg.ackno.has_value()) {
    // 还可以特殊考虑窗口尺寸，因为如果是刚开始的，那么可以修改窗口尺寸
    if(next_seqno_ == isn_) {
      window_size_ = msg.window_size;
    }
    // 说明响应结果不正确，直接退出
    return;
  }

  // 特殊情况：ackno > next_seq_no的是无效的，应当ignore
  if(msg.ackno.value().unwrap(isn_, 0) > next_seqno_.unwrap(isn_, 0)) {
    return;
  }
  // 这种情况需不需要考虑？，也就是ackno是窗口左边的情况（也即之前已经ack了的）
  if(msg.ackno.value().unwrap(isn_, 0) < window_left_bound_.unwrap(isn_, 0)) {
    return;
  }

  // successful ack new data
  if(msg.ackno.value().unwrap( isn_, 0 ) > window_left_bound_.unwrap( isn_, 0)) {
    // 说明可以再次发送0message了
    zero_message_sent_ = false;
  }

  // 再进行相应的更新，注意更新的是窗口左边界，以及对应的窗口的大小
  window_left_bound_ = msg.ackno.value();
  window_size_ = msg.window_size;
  // 更新outstanding data的数量，也就是ackno之后的，next_seqno_之前的所有（注意是累计确认机制）

  bool isAckNewData {false};

  // 收到一个数据，尝试从其中删除，这里面假设了按照段的方式存储，且假设如果seqno+seqlen==ackno，那么说明回复的就是这个段
  auto target_iter = ranges::find_if(outstanding_segments_ , [&](const TCPSenderMessage& message) -> bool {
    return message.seqno  + message.sequence_length() == msg.ackno.value();
  });

  if(target_iter != outstanding_segments_.end()) {// 说明找到这个段
    // cout << "target_iter:" << target_iter->seqno.unwrap(isn_, 0) << endl;
    // 将该段及前面的所有段都删除，注意先++
    outstanding_segments_.erase(outstanding_segments_.begin(), ++target_iter);
    isAckNewData = true;
  }

  if(isAckNewData) {
    sequence_numbers_in_flight_ = next_seqno_.unwrap(isn_, 0) - window_left_bound_.unwrap(isn_, 0);// 还得要考虑考虑
  }

  // cout << "outstanding size:" << outstanding_segments_.size() << endl;

  // 5.When all outstanding data has been acknowledged, stop the retransmission timer
  // outstanding data 发生变化时（也就是有新的acknowledge时）肯定是发生在receive中的，因此只需要在这里判断
  if(outstanding_segments_.empty()) {
    retransmission_timer_.stop();
  }

  // 7. the receiver gives the sender an ackno。注意正确性：即保证ack必须是针对于window里的数据
  RTO_ms_ = initial_RTO_ms_; // a
  if(!outstanding_segments_.empty() && isAckNewData) { // b
    retransmission_timer_.restart( alive_ms_, RTO_ms_ ); // 这意味着需要将已经收到的删除
  }
  consecutive_retransmissions_ = 0; // c

}

void TCPSender::tick( uint64_t ms_since_last_tick, const TransmitFunction& transmit )
{
  // 更新生存时间
  alive_ms_ += ms_since_last_tick;

  // cout << "tick 被调用，当前已经经过" << alive_ms_ << endl;

  // 6. If tick is called and the retransmission timer has expired
  if(retransmission_timer_.expired( alive_ms_ )) {
    // cout << "retransmission timeout" << endl;
    // a.
    if(!outstanding_segments_.empty()) {
      transmit( outstanding_segments_.front() );
    }
    // b. If the window size is nonzero
    if(window_size_ > 0) {
      consecutive_retransmissions_++;
      RTO_ms_ *= 2;// 扩大2倍 b.ii
    }
    // c. Reset the retransmission timer and start it
    retransmission_timer_.restart(alive_ms_, RTO_ms_ );
  }

}

void TCPSender::update_after_transmit(const TCPSenderMessage &sender_message){
  next_seqno_ = next_seqno_ + 1;
  outstanding_segments_.emplace_back(sender_message);
  sequence_numbers_in_flight_ =  next_seqno_.unwrap( isn_, 0 ) - window_left_bound_.unwrap(isn_, 0);
  // 4. 包含的数据占据了seqno的条件下（实际上不需要）：如果timer not running -> start（设置新的RTO）
  if(sender_message.sequence_length() > 0 && !retransmission_timer_.is_running()) {
    retransmission_timer_.restart( alive_ms_, RTO_ms_ ); // 是restart还是start，或者其他？
  }
}


void TCPSender::RetransmissionTimer::start( uint64_t start_time){
  is_running_ = true;
  start_time_ = start_time;
}

void TCPSender::RetransmissionTimer::stop() {
  is_running_ = false;
}

void TCPSender::RetransmissionTimer::reset( const uint64_t timeout){
  timeout_ = timeout;
}

void TCPSender::RetransmissionTimer::restart(uint64_t start_time, uint64_t timeout){
  start_time_ = start_time;
  timeout_ = timeout;
  is_running_ = true; // 实际上不需要
}

bool TCPSender::RetransmissionTimer::expired(const uint64_t now ) const{
  // cout << is_running() << " "  << now << " " << start_time_ << " " << timeout_ << endl;
  return is_running() && now >= start_time_ + timeout_;
}

bool TCPSender::RetransmissionTimer::is_running() const{
  return is_running_;
}


