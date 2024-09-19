#include "tcp_receiver.hh"

#include <iostream>
#include <ostream>

using namespace std;

void TCPReceiver::receive( TCPSenderMessage message )
{
  // RST更新
  if(message.RST) {// 如果被重置了，则抛出错误
    reassembler_.reader().set_error();
    RST_ = reassembler_.reader().has_error();
  } else if(RST_) {
    return;
  }
  // SYN更新
  if(message.SYN) {// 说明遇到了SYN标志，此时才将SYN_置为true，同时要设置zero_point为初始seqno
    SYN_ = true;
    zero_point_ = message.seqno;
  }
  if(!SYN_) {// 说明到目前为止没有遇到SYN，则直接忽略，那么ackno_将不会设置信息
    return;
  }

  // 到此说明是正常的请求（在SYN之后的情况）


  // 获取first_index
  uint64_t first_index = message.seqno.unwrap(zero_point_.value(), reassembler_.writer().bytes_pushed() + SYN_ + reassembler_.writer().is_closed() );
  first_index -= !message.SYN; // 特殊考虑SYN和数据一同出现的情况
  // cout << "first_index: " << first_index << endl;


  // 执行插入操作
  reassembler_.insert( first_index, message.payload, message.FIN );


  // 更新ackno_
  ackno_ = Wrap32::wrap(reassembler_.writer().bytes_pushed() + SYN_ + reassembler_.writer().is_closed(), zero_point_.value());// 将SYN和FIN算上
}

TCPReceiverMessage TCPReceiver::send() const
{
  // Your code here.
  return {.ackno = ackno_, .window_size = static_cast<uint16_t>(min<uint64_t>(reassembler_.writer().available_capacity(), UINT16_MAX)), .RST = RST_ || reassembler_.reader().has_error()};
}
