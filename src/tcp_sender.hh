#pragma once

#include "byte_stream.hh"
#include "tcp_receiver_message.hh"
#include "tcp_sender_message.hh"

#include <cstdint>
#include <functional>
#include <list>
#include <memory>
#include <optional>
#include <queue>

class TCPSender
{
public:
  /* Construct TCP sender with given default Retransmission Timeout and possible ISN */
  TCPSender( ByteStream&& input, Wrap32 isn, uint64_t initial_RTO_ms )
    : input_( std::move( input ) )
    , isn_( isn )
    , initial_RTO_ms_( initial_RTO_ms )
    , RTO_ms_( initial_RTO_ms )
    , next_seqno_( isn )
    , window_left_bound_( isn )
    , retransmission_timer_( initial_RTO_ms )
  {}

  /* Generate an empty TCPSenderMessage */
  TCPSenderMessage make_empty_message() const;

  /* Receive and process a TCPReceiverMessage from the peer's receiver */
  void receive( const TCPReceiverMessage& msg );

  /* Type of the `transmit` function that the push and tick methods can use to send messages */
  using TransmitFunction = std::function<void( const TCPSenderMessage& )>;

  /* Push bytes from the outbound stream */
  void push( const TransmitFunction& transmit );

  /* Time has passed by the given # of milliseconds since the last time the tick() method was called */
  void tick( uint64_t ms_since_last_tick, const TransmitFunction& transmit );

  // Accessors
  uint64_t sequence_numbers_in_flight() const;  // How many sequence numbers are outstanding?
  uint64_t consecutive_retransmissions() const; // How many consecutive *re*transmissions have happened?
  Writer& writer() { return input_.writer(); }
  const Writer& writer() const { return input_.writer(); }

  // Access input stream reader, but const-only (can't read from outside)
  const Reader& reader() const { return input_.reader(); }

private:
  // Variables initialized in constructor
  ByteStream input_;
  Wrap32 isn_;
  uint64_t initial_RTO_ms_;
  uint64_t RTO_ms_;
  Wrap32 next_seqno_; // 下一个要发送的next_seqno_
  Wrap32 window_left_bound_; // 对应接收方窗口的左边界
  uint16_t window_size_{1}; // 接收方的窗口尺寸
  uint64_t alive_ms_{0}; // 生存时间
  uint64_t sequence_numbers_in_flight_{0}; // 有多少个序号已经发送但未确认
  uint64_t consecutive_retransmissions_{0}; // 有多少个连续重传的次数
  bool SYN_message_ {false};// 指示是否是第一个用于同步的message
  bool FIN_ {false}; // 是否在此之前遇到过FIN
  bool RST_ {false};
  bool zero_message_sent_ {false};
  // 存储outstanding segments，并且按照sequence number有序存放
  std::list<TCPSenderMessage> outstanding_segments_{};
  class RetransmissionTimer
  {
  public:
    explicit RetransmissionTimer(uint64_t timeout): timeout_(timeout) {};
    void start(uint64_t start_time);// 重新设置超时时间并启动
    void stop();
    void reset(uint64_t timeout); // 重新设置超时时间，但不启动
    void restart(uint64_t start_time, uint64_t timeout); // 重新设置超时时间，同时启动
    [[nodiscard]] bool expired(uint64_t now) const;// 判断当前时间是否已经超时，如果没有running，则直接返回false
    [[nodiscard]] bool is_running() const;
    // void stop();// 停止
  private:
    uint64_t timeout_; // 设置的超时时间（实际上是间隔）
    uint64_t start_time_{0};// 调用start时设置的时间
    bool is_running_{false};
  };
  RetransmissionTimer retransmission_timer_;

  void update_after_transmit(const TCPSenderMessage &sender_message);
};
