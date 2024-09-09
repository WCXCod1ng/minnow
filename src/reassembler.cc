#include "reassembler.hh"

#include <iostream>

using namespace std;

void Reassembler::insert( uint64_t first_index, string data, bool is_last_substring )
{
  // 从头开始遍历，直到first_index位置是没有存在的
  uint64_t k {0};
  for(k = 0; k < data.size(); k++) {
    if(!flag_.contains(first_index+k)) {
      break;
    }
  }
  // // 得到[0, k)是存在的
  if(k == data.size()) {// 整个都存在
    try_close( first_index, data, is_last_substring );
    return;
  }
  first_index += k;
  data = data.substr(k);


  // cout << "begin insert" << first_index << "str = " << data << endl;
  uint64_t start_index, max_index;
  if(expect_next_index_ < first_index) {
    // 说明期待的迟到，后面的早到
    // 这种情况下只需要考虑那些是第一次来的byte，将其组合起来放入map中即可
    max_index = max(output_.writer().available_capacity() + expect_next_index_, data.size() + first_index); // 设置遍历的最大下标，注意不包括，请注意这里只是保守保证，其内部必须单独判断
    start_index = first_index;

  } else { // expect_next_index_ >= first_index 的情况
    // 否则说明这一定是一个存在重复的substring，应当截取不重复的部分，也就是expect_next_index_之后的内容
    max_index = max(output_.writer().available_capacity() + expect_next_index_, data.size() + first_index); // 设置遍历的最大下标，注意不包括
    start_index = expect_next_index_; // 注意，开始位置总是expect_next_index_
  }
  // cout << "start_index" << start_index << endl;
  // cout << "max_index" << max_index << endl;

  string buffer {}; // 用于缓存将要写给writer的字符串
  // 遍历index
  buffer.reserve(output_.writer().available_capacity());
  uint64_t i { start_index };
  while(i < max_index) {
    // cout << i << endl;
    if (i >= expect_next_index_ + output_.writer().available_capacity()) { // 说明到末尾，可以退出了
      break;
    }
    if(flag_.contains(i)) {
      // 如果该索引包含，则说明它之前存在过，获取对应的string
      uint64_t l = i + data_[i].size(); // 向后跳跃，因为在此期间的一定都被记录过了
      // // 修改存储的字节数量
      // bytes_pending_ -= data_[i].size();
      // 遍历结束后将为不包含的位置
      // 此时应当将map中的其删除,并且拼接到buffer中
      buffer += data_[i];
      data_.erase(i);
      // 更新i的位置
      i = l;
      continue;
    }
    // 否则说明不包含该索引
    if (i >= first_index + data.size()) {
      // 且达到了本次substring的末尾，同样也退出
      break;
    }
    flag_.insert(i);
    // 否则说明要么没有达到最大长度，要么是紧邻的还在缓存的内容，应当读出来
    // 拼接到后面
    buffer += data[i - first_index];
    // 后移
    i++;
    // 修改存储的字节数量
    bytes_pending_++;
  }

  if(!buffer.empty()) {
    if(expect_next_index_ < first_index) {
      // 拿到buffer之后不是写入writer，而是放入map，切expect_next_index不变
      data_[start_index] = buffer; // 注意起始位置是start_index
      // flag_.insert(start_index); // 也要插入flag
    } else {
      // 从expect_next_index到i（不包括i）的这部分就是需要write进的部分
      output_.writer().push( buffer );
      // cout << "wrote：" << buffer << endl;
      // 同时需要更新下个期待的索引值
      expect_next_index_ = i;// 更新到这里
      // 修改存储的字节数量，注意要从i算，因为i是有可能超过max_index的
      bytes_pending_ -= i - start_index;
      // 还要从flag_中删除标记（如果存在）
      // erase_if(flag_, [&i](uint64_t key) -> bool {
      //   return key < i;
      // });
      for(uint64_t j = start_index;j < i;j++) {
        flag_.erase(j);
      }
    }
  }


  // 遇到了last_substring，则应当记录最后一个字节的下一个下标
  // cout << expect_next_index_ << " " << first_index << " " << data.size() << endl;
  try_close( first_index, data, is_last_substring );
}

uint64_t Reassembler::bytes_pending() const
{
  // Your code here.
  return bytes_pending_;
}

// void Reassembler::push_to_output(uint64_t start_index, uint64_t end_index, const std::string& data, uint64_t first_index){
//   string buffer;
//   buffer.reserve(output_.writer().available_capacity());
//   uint64_t i {start_index};
//   while(i < end_index) {
//     if(flag_.contains(i)) {
//       // 如果该索引包含，则说明它之前存在过，获取对应的string
//       uint64_t l;
//       for(l = data_[i].size();flag_.contains(l);i--); // 需不需要考虑越界的问题
//       // 遍历结束后将为不包含的位置
//       // 此时应当将map中的其删除,并且拼接到buffer中
//       buffer += data_[i];
//       data_.erase(i);
//       // 更新i的位置
//       i = l;
//       continue;
//     }
//     // 否则说明不包含该索引，那么需要拼接上去
//     buffer += data[i - first_index];
//   }
// }

void Reassembler::try_close(uint64_t first_index, const std::string data, bool is_last_substring ){
  if(is_last_substring) {
    last_byte_next_index_ = first_index + data.size();
  }
  // 关闭的条件
  if(expect_next_index_ == last_byte_next_index_) {
    output_.writer().close();
  }
}


