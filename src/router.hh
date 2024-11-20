#pragma once

#include <memory>
#include <optional>

#include "exception.hh"
#include "network_interface.hh"

// \brief A router that has multiple network interfaces and
// performs longest-prefix-match routing between them.
class Router
{
public:
  // Add an interface to the router
  // \param[in] interface an already-constructed network interface
  // \returns The index of the interface after it has been added to the router
  size_t add_interface( std::shared_ptr<NetworkInterface> interface )
  {
    _interfaces.push_back( notnull( "add_interface", std::move( interface ) ) );
    return _interfaces.size() - 1;
  }

  // Access an interface by index
  std::shared_ptr<NetworkInterface> interface( const size_t N ) { return _interfaces.at( N ); }

  // Add a route (a forwarding rule)
  void add_route( uint32_t route_prefix,
                  uint8_t prefix_length,
                  std::optional<Address> next_hop,
                  size_t interface_num );

  // Route packets between the interfaces
  void route();

private:
  // The router's collection of network interfaces
  std::vector<std::shared_ptr<NetworkInterface>> _interfaces {};

  // a forwarding rule
  struct Rule {
    uint32_t route_prefix;
    uint8_t prefix_length;
    std::optional<Address> next_hop;
    size_t interface_num;
    Rule( uint32_t route_prefix_, uint8_t prefix_length_, std::optional<Address> next_hop_, size_t interface_num_ ): route_prefix( route_prefix_ ), prefix_length( prefix_length_ ), next_hop( next_hop_ ), interface_num( interface_num_ ) {}
  };
  // 存储路由表，是一个vector，存储所有的路由规则
  std::vector<Rule> _rules {};

  // 辅助函数：看是否能够匹配
  // 查看传入的ip_address是否能够与规则i匹配
  [[nodiscard]] bool check_match(std::vector<Rule>::const_iterator it, uint32_t ip_address)const;
};
