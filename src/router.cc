#include "router.hh"

#include <iostream>
#include <limits>

using namespace std;

// route_prefix: The "up-to-32-bit" IPv4 address prefix to match the datagram's destination address against
// prefix_length: For this route to be applicable, how many high-order (most-significant) bits of
//    the route_prefix will need to match the corresponding bits of the datagram's destination address?
// next_hop: The IP address of the next hop. Will be empty if the network is directly attached to the router (in
//    which case, the next hop address should be the datagram's final destination).
// interface_num: The index of the interface to send the datagram out on.
void Router::add_route( const uint32_t route_prefix,
                        const uint8_t prefix_length,
                        const optional<Address> next_hop,
                        const size_t interface_num )
{
  cerr << "DEBUG: adding route " << Address::from_ipv4_numeric( route_prefix ).ip() << "/"
       << static_cast<int>( prefix_length ) << " => " << ( next_hop.has_value() ? next_hop->ip() : "(direct)" )
       << " on interface " << interface_num << "\n";

  // Your code here.
  _rules.emplace_back( route_prefix, prefix_length, next_hop, interface_num );
}

// Go through all the interfaces, and route every incoming datagram to its proper outgoing interface.
void Router::route()
{
  // 遍历每个network interface
  for ( const auto & _interface : _interfaces) {
    // 对于每个network interface，遍历它的每个接收到的信息
    auto& datagram_queue = _interface->datagrams_received();
    // cerr << "interface" << _interface->name() << "received" << datagram_queue.size() << endl;
    while(!datagram_queue.empty()) {
      // 获取数据队列中的首元素并弹出
      InternetDatagram& datagram = datagram_queue.front();

      // 先判断TTL，看是否为0或者1（减一之后就成为了0），如果是这样，那么直接丢弃，continue
      if(datagram.header.ttl == 0 || datagram.header.ttl == 1) {
        datagram_queue.pop();
        continue;
      }
      // TTL减一
      datagram.header.ttl--;
      datagram.header.compute_checksum();// 重新计算校验和

      // 下面是正常操作：对与该信息（internet datagram，进行路由操作）
      // 记录能够匹配上的最长的前缀长度：
      uint8_t max_matching_length {0};
      auto  max_matching_length_iter {_rules.cend()}; // 记录其索引，如果为end表示没有可以匹配的规则
      // cout << "send to " << Address::from_ipv4_numeric(datagram.header.dst).ip() << endl;
      for(auto it = _rules.cbegin(); it != _rules.cend(); ++it) {
        if (check_match( it, datagram.header.dst )) {
          // cerr << "match:" << Address::from_ipv4_numeric(it->route_prefix).ip() << " len:" << it->prefix_length << endl;
          // 匹配成功，则更新索引长度和索引位置
          if(it->prefix_length >= max_matching_length) { // 注意是大于等于（因为需要保证默认路由（通常长度为0）也可以匹配到）（或者其他方法应当也可以）
            max_matching_length = it->prefix_length;
            max_matching_length_iter = it;
          }
        }
      }

      // 结束后可能得到最长匹配
      if(max_matching_length_iter != _rules.cend()) {
        uint32_t target_address {};
        // 得到最长匹配前缀的结果索引，按此进行路由
        if(!max_matching_length_iter->next_hop.has_value()) {
          // 如果next_hop是empty，那么说明下一个是直达的，将数据报的destination address作为转交的ip address
          target_address = datagram.header.dst;
        } else {
          // 否则就是next_hop指示的地址为转交的ip address
          target_address = max_matching_length_iter->next_hop.value().ipv4_numeric();
        }

        // 从指定接口i发送出去，目标地址为target_address
        interface(max_matching_length_iter->interface_num)->send_datagram(
          datagram, Address::from_ipv4_numeric( target_address ) );

      } // 如果发现没有匹配的结果，应当丢弃，直接不用管，由于在末尾，可以看做continue

      datagram_queue.pop();
    }
  }
}

bool Router::check_match(const vector<Rule>::const_iterator it, const uint32_t ip_address)const{
  // 看编号为i的规则是否与目标ip address匹配
  const uint32_t route_prefix {it->route_prefix};
  const uint8_t prefix_length {it->prefix_length};
  // 异常情况
  if(prefix_length == 0) {// 长度为0的是默认路由，一定可以匹配
    return true;
  }
  if(prefix_length > 32) {// 长度超过32的不可能
    return false;
  }
  return (route_prefix >> (32-prefix_length)) == (ip_address >> (32-prefix_length));
}

