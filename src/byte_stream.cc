#include "byte_stream.hh"
#include <iostream>

using namespace std;

ByteStream::ByteStream( uint64_t capacity ) :capacity_(capacity) {}

bool Writer::is_closed() const
{
  // cout << "Writer::is_closed()" << endl;
  // Your code here.
  return closed_;
}

void Writer::push( string data )
{
  // cout << "Writer::push" << endl;
  if(available_capacity() > 0) {
    // 否则从后面的直接加上，同样注意容量
    const uint64_t len = min( data.size(), available_capacity());
    buffer_.insert(buffer_.end(), data.begin(), data.begin() + len);
    // buffer_ += data.substr(0, len);
    // 更新计数
    count_pushed += len;
  }
}

void Writer::close()
{
  // cout << "Writer::close()" << endl;
  // Your code here.
  closed_ = true;
}

uint64_t Writer::available_capacity() const
{
  // cout << "Writer::available_capacity()" << endl;
  // Your code here.
  return capacity_ - buffer_.size();
}

uint64_t Writer::bytes_pushed() const
{
  // cout << "Writer::bytes_pushed()" << endl;
  // Your code here.
  return count_pushed;
}

bool Reader::is_finished() const
{
  // cout << "Reader::is_finished()" << endl;
  // Your code here.
  return closed_ && buffer_.empty();
}

uint64_t Reader::bytes_popped() const
{
  // cout << "Reader::bytes_popped()" << endl;
  // Your code here.
  return count_popped;
}

string_view Reader::peek() const
{
  // cout << "Reader::peek()" << endl;

  // return view_queue_
  return string_view(buffer_);
}

void Reader::pop( uint64_t len )
{
  // cout << "Reader::pop()" << endl;
  // Your code here.
  if (bytes_buffered() < len) {
    set_error();
    return; // buffer中的元素数量不足len个
  }
  buffer_.erase(buffer_.begin(), buffer_.begin() + len);
  count_popped += len;// 计数更新
}

uint64_t Reader::bytes_buffered() const
{
  // cout << "Reader::bytes_buffered()" << endl;
  // Your code here.
  return buffer_.size();
}
