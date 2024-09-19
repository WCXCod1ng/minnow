#include "wrapping_integers.hh"

using namespace std;

Wrap32 Wrap32::wrap( uint64_t n, Wrap32 zero_point )
{
  // Your code here.
  return Wrap32 { static_cast<uint32_t>( (n + zero_point.raw_value_ ) % mod ) };
}

uint64_t Wrap32::unwrap( Wrap32 zero_point, uint64_t checkpoint ) const
{
  // Your code here.
  uint64_t width = (this->raw_value_ - zero_point.raw_value_ + mod) % mod; // 类似于环形队列计算元素个数
  // 因此结果可能是 k * mod + width
  if(checkpoint <= width) {// 特殊判断k为负数的可能
    return width;
  }
  uint64_t k = (checkpoint - width) / mod;
  if(checkpoint <= width + k * mod + mod / 2) { // k为非负数的可能
    return k * mod + width;
  }
  return (k+1) * mod + width;
}
