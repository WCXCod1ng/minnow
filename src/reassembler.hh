#pragma once

#include "byte_stream.hh"

#include <unordered_map>
#include <unordered_set>
#include <climits>

class Reassembler
{
public:
  // Construct Reassembler to write into given ByteStream.
  explicit Reassembler( ByteStream&& output ) : output_( std::move( output ) ) {}

  /*
   * Insert a new substring to be reassembled into a ByteStream.
   *   `first_index`: the index of the first byte of the substring
   *   `data`: the substring itself
   *   `is_last_substring`: this substring represents the end of the stream
   *   `output`: a mutable reference to the Writer
   *
   * The Reassembler's job is to reassemble the indexed substrings (possibly out-of-order
   * and possibly overlapping) back into the original ByteStream. As soon as the Reassembler
   * learns the next byte in the stream, it should write it to the output.
   *
   * If the Reassembler learns about bytes that fit within the stream's available capacity
   * but can't yet be written (because earlier bytes remain unknown), it should store them
   * internally until the gaps are filled in.
   *
   * The Reassembler should discard any bytes that lie beyond the stream's available capacity
   * (i.e., bytes that couldn't be written even if earlier gaps get filled in).
   *
   * The Reassembler should the stream after writing the last byte.
   */
  void insert( uint64_t first_index, std::string data, bool is_last_substring );

  // How many bytes are stored in the Reassembler itself?
  uint64_t bytes_pending() const;

  // Access output stream reader
  Reader& reader() { return output_.reader(); }
  const Reader& reader() const { return output_.reader(); }

  // Access output stream writer, but const-only (can't write from outside)
  const Writer& writer() const { return output_.writer(); }

private:
  // 将给定的string push到内部的byteStream中，如果长度过长（以至于超过了available_capacity），那么应当截断
  // void push_to_output( uint64_t start_index, uint64_t end_index , const std::string& data, uint64_t first_index);
  void try_close(uint64_t first_index, const std::string data, bool is_last_substring );

  ByteStream output_; // the Reassembler writes to this ByteStream
  uint64_t expect_next_index_ {0}; // Reassembler期望的下一个索引，如果遇到了直接将从它开始的字符串写给byteStream
  uint64_t last_byte_next_index_ {LONG_LONG_MAX}; // 获取最后一个字节的下一个下标，仅仅当遇到了last_substring时才会考虑，否则应当初始化为max（不知道合不合理）
  // std::vector<char> buffer_; // 以expect为开始，缓存那些还没来得及送入到byteSteam的内容
  // uint64_t arrived_first_index_ {0}; // 已经到达的第一个索引，如果发现它与expect相等，则立即进行插入，还有可能需要map操作，记录所有到达的字符串信息
  // uint64_t arrived_last_index_ {0}; // 记录最后一个到达的索引，它用于断定是否超过了缓冲区的大小
  uint64_t bytes_pending_ {0}; // 记录在buffer_中还有多少字节的数据没有被送入到byteStream，Reassembler缓冲区的大小等于byteStream的available_capacity()
  std::unordered_set<uint64_t> flag_{}; // 存储是否每一位收到了，key = the index of byte
  std::unordered_map<uint64_t, std::string> data_{}; // 记录数据，key=first_index，value=string
};
