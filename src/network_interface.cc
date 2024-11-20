#include <iostream>

#include "arp_message.hh"
#include "exception.hh"
#include "network_interface.hh"

using namespace std;

//! \param[in] ethernet_address Ethernet (what ARP calls "hardware") address of the interface
//! \param[in] ip_address IP (what ARP calls "protocol") address of the interface
NetworkInterface::NetworkInterface( string_view name,
                                    shared_ptr<OutputPort> port,
                                    const EthernetAddress& ethernet_address,
                                    const Address& ip_address )
  : name_( name )
  , port_( notnull( "OutputPort", move( port ) ) )
  , ethernet_address_( ethernet_address )
  , ip_address_( ip_address )
{
  cerr << "DEBUG: Network interface has Ethernet address " << to_string( ethernet_address ) << " and IP address "
       << ip_address.ip() << "\n";
}

//! \param[in] dgram the IPv4 datagram to be sent
//! \param[in] next_hop the IP address of the interface to send it to (typically a router or default gateway, but
//! may also be another host if directly connected to the same network as the destination) Note: the Address type
//! can be converted to a uint32_t (raw 32-bit IP address) by using the Address::ipv4_numeric() method.
void NetworkInterface::send_datagram( const InternetDatagram& dgram, const Address& next_hop )
{
  // create an Ethernet frame
  EthernetFrame ethernet_frame;
  // 进行编码
  Serializer serializer;
  // 填充ethernet_frame.payload，其格式应当为internet datagram
  dgram.serialize(serializer);
  // 将internet datagram的编码结果（包含header）整体作为ethernet frame的payload
  ethernet_frame.payload = serializer.output();

  // 根据ip地址，寻找对应的EthernetAddress，看是否在自己的缓存中，以此来决定header的格式
  if(ip_ethernet_map_.contains(next_hop.ipv4_numeric())) {// 如果map中包含制定的ip，那么可以据此得到制定的EthernetAddress，并直接发送
    // 数据帧header为普通格式ipv4
    ethernet_frame.header = {.dst = ip_ethernet_map_[next_hop.ipv4_numeric()].second, .src = ethernet_address_, .type = EthernetHeader::TYPE_IPv4};

    // 调用transmit进行传输数据帧
    transmit( ethernet_frame );
  } else {// 不知道，需要广播
    // 填充数据帧header，将目的地址变成全1
    ethernet_frame.header = {.dst = ETHERNET_BROADCAST, .src = ethernet_address_, .type = EthernetHeader::TYPE_IPv4};

    // 不管是否存储过，都需要加入到list中，得到将来目的EthernetAddress知道之后再重新发送，而且要显示指出目的ip（在receive中实现）
    ethernet_frames_.emplace_back(next_hop.ipv4_numeric(), ethernet_frame);

    // 构建专门的arp请求帧
    EthernetFrame arp_request_ethernet_frame;
    arp_request_ethernet_frame.header = {.dst = ETHERNET_BROADCAST, .src = ethernet_address_, .type = EthernetHeader::TYPE_ARP}; // 注意arp请求的header和数据帧的header不一样
    // 填充arp_request_ethernet_frame.payload，其格式应当为arp。不需要填写target_ethernet_address，因为还不知道
    // 构建arp message
    ARPMessage arp_request;
    arp_request.opcode = ARPMessage::OPCODE_REQUEST;
    arp_request.sender_ethernet_address = ethernet_address_;
    arp_request.sender_ip_address = ip_address_.ipv4_numeric();
    arp_request.target_ip_address = next_hop.ipv4_numeric();
    // 编码
    Serializer arp_request_serializer;
    arp_request.serialize( arp_request_serializer );
    // 将arp message的编码结果放入arp请求帧的payload
    arp_request_ethernet_frame.payload = arp_request_serializer.output();

    // 最近上一次存储的时间距离现在还不超过5s（反之：之前没有存储，或者存储了但是时间距离现在已经超过了5s）
    if(!last_send_time_map_.contains(next_hop.ipv4_numeric()) || last_send_time_map_[next_hop.ipv4_numeric()] + arp_timeout_ms_ < cur_ms_) {
      // 需要额外transmit arp请求帧，并且更新map
      last_send_time_map_[next_hop.ipv4_numeric()] = cur_ms_;
      transmit( arp_request_ethernet_frame );
    }

  }
}

//! \param[in] frame the incoming Ethernet frame
void NetworkInterface::recv_frame( const EthernetFrame& frame )
{
  // EthernetFrame& ethernet_frame { const_cast<EthernetFrame&>(frame)};
  // 忽略所有不是针对自己的帧（也就是目的地址和自己不一样，并且也不是广播
  if(frame.header.dst != ethernet_address_ && frame.header.dst != ETHERNET_BROADCAST) {
    return;
  }

  // 构造parser，下面根据类型对payload分别解析
  Parser parser {frame.payload};
  // 判断接收到的ethernet帧的类型
  if(frame.header.type == EthernetHeader::TYPE_IPv4) {// if the inbound frame is IPv4
    InternetDatagram dgram;
    dgram.parse(parser);
    if(!parser.has_error()) {
      // 解析无误，放入接受队列
      datagrams_received_.push( dgram );
    }
  } else if(frame.header.type == EthernetHeader::TYPE_ARP) {// if the inbound frame is ARP
    ARPMessage arp_message;
    arp_message.parse(parser);
    if(!parser.has_error()) {
      // successful
      // remember the mapping between the sender's IP address and Ethernet address for 30 seconds, both requests and replies
      ip_ethernet_map_[arp_message.sender_ip_address] = make_pair( cur_ms_, arp_message.sender_ethernet_address );
      if(arp_message.target_ethernet_address != ETHERNET_BROADCAST) { // 广播发送的target为全1，不予考虑
        ip_ethernet_map_[arp_message.target_ip_address] = make_pair(cur_ms_, arp_message.target_ethernet_address);
      }

      // 如果该arp request是针对于自己的，那么send reply
      if(arp_message.opcode == ARPMessage::OPCODE_REQUEST && arp_message.target_ip_address == ip_address_.ipv4_numeric()) {
        // 构建ethernet frame
        EthernetFrame ethernet_frame;
        ethernet_frame.header = {.dst = arp_message.sender_ethernet_address, .src = ethernet_address_, .type = EthernetHeader::TYPE_ARP};

        // 下面是将arpmessage编码为ethernet frame的payload
        ARPMessage arp_reply = arp_message;
        arp_reply.opcode = ARPMessage::OPCODE_REPLY;
        arp_reply.target_ethernet_address = arp_message.sender_ethernet_address;
        arp_reply.target_ip_address = arp_message.sender_ip_address;
        arp_reply.sender_ethernet_address = ethernet_address_;
        arp_reply.sender_ip_address = ip_address_.ipv4_numeric();
        Serializer serializer;
        arp_reply.serialize( serializer );

        ethernet_frame.payload = serializer.output();

        // 发送
        transmit( ethernet_frame );
      }


      // 注意：更新完映射之后，可能queue中的内容可以发送了
      for(auto it = ethernet_frames_.begin(); it != ethernet_frames_.end();) {
        if(ip_ethernet_map_.contains(it->first)) {// 包含了这映射，那么可以从中删除
          // 注意删除之前要将对应的帧重新发送出去（修改dst）
          it->second.header.dst = ip_ethernet_map_[it->first].second;
          transmit(it->second);
          // 删除
          it = ethernet_frames_.erase(it);
        } else {
          ++it;
        }
      }
    }
  }
}

//! \param[in] ms_since_last_tick the number of milliseconds since the last call to this method
void NetworkInterface::tick( const size_t ms_since_last_tick )
{
  // 更新时刻
  cur_ms_ += ms_since_last_tick;

  // 检查是否有过期的映射，如果有，则从其中删除
  for(auto it = ip_ethernet_map_.begin(); it != ip_ethernet_map_.end();) {
    if(cur_ms_ > it->second.first + timeout_mapping_ms_) {
      // 超时了，应当删除
      it = ip_ethernet_map_.erase( it ); // 注意只能通过这种方式删除，否则会导致迭代器失效
    } else {
      // 没超时，那么it前进
      ++it;
    }
  }
}
