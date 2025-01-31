# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /tmp/minnow

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/minnow/cmake-build-debug-docker

# Utility rule file for format.

# Include any custom commands dependencies for this target.
include CMakeFiles/format.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/format.dir/progress.make

CMakeFiles/format:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Formatting source code..."
	clang-format -i /tmp/minnow/apps/bidirectional_stream_copy.cc /tmp/minnow/apps/bidirectional_stream_copy.hh /tmp/minnow/apps/endtoend.cc /tmp/minnow/apps/tcp_ipv4.cc /tmp/minnow/apps/tcp_native.cc /tmp/minnow/apps/webget.cc /tmp/minnow/src/byte_stream.cc /tmp/minnow/src/byte_stream.hh /tmp/minnow/src/byte_stream_helpers.cc /tmp/minnow/src/network_interface.cc /tmp/minnow/src/network_interface.hh /tmp/minnow/src/reassembler.cc /tmp/minnow/src/reassembler.hh /tmp/minnow/src/router.cc /tmp/minnow/src/router.hh /tmp/minnow/src/tcp_minnow_socket.cc /tmp/minnow/src/tcp_receiver.cc /tmp/minnow/src/tcp_receiver.hh /tmp/minnow/src/tcp_sender.cc /tmp/minnow/src/tcp_sender.hh /tmp/minnow/src/wrapping_integers.cc /tmp/minnow/src/wrapping_integers.hh /tmp/minnow/tests/byte_stream_basics.cc /tmp/minnow/tests/byte_stream_capacity.cc /tmp/minnow/tests/byte_stream_many_writes.cc /tmp/minnow/tests/byte_stream_one_write.cc /tmp/minnow/tests/byte_stream_speed_test.cc /tmp/minnow/tests/byte_stream_stress_test.cc /tmp/minnow/tests/byte_stream_test_harness.hh /tmp/minnow/tests/byte_stream_two_writes.cc /tmp/minnow/tests/common.cc /tmp/minnow/tests/common.hh /tmp/minnow/tests/conversions.hh /tmp/minnow/tests/net_interface.cc /tmp/minnow/tests/network_interface_test_harness.hh /tmp/minnow/tests/reassembler_cap.cc /tmp/minnow/tests/reassembler_dup.cc /tmp/minnow/tests/reassembler_holes.cc /tmp/minnow/tests/reassembler_overlapping.cc /tmp/minnow/tests/reassembler_seq.cc /tmp/minnow/tests/reassembler_single.cc /tmp/minnow/tests/reassembler_speed_test.cc /tmp/minnow/tests/reassembler_test_harness.hh /tmp/minnow/tests/reassembler_win.cc /tmp/minnow/tests/receiver_test_harness.hh /tmp/minnow/tests/recv_close.cc /tmp/minnow/tests/recv_connect.cc /tmp/minnow/tests/recv_reorder.cc /tmp/minnow/tests/recv_reorder_more.cc /tmp/minnow/tests/recv_special.cc /tmp/minnow/tests/recv_transmit.cc /tmp/minnow/tests/recv_window.cc /tmp/minnow/tests/router.cc /tmp/minnow/tests/send_ack.cc /tmp/minnow/tests/send_close.cc /tmp/minnow/tests/send_connect.cc /tmp/minnow/tests/send_extra.cc /tmp/minnow/tests/send_retx.cc /tmp/minnow/tests/send_transmit.cc /tmp/minnow/tests/send_window.cc /tmp/minnow/tests/sender_test_harness.hh /tmp/minnow/tests/test_should_be.hh /tmp/minnow/tests/wrapping_integers_cmp.cc /tmp/minnow/tests/wrapping_integers_extra.cc /tmp/minnow/tests/wrapping_integers_roundtrip.cc /tmp/minnow/tests/wrapping_integers_unwrap.cc /tmp/minnow/tests/wrapping_integers_wrap.cc /tmp/minnow/util/address.cc /tmp/minnow/util/address.hh /tmp/minnow/util/arp_message.cc /tmp/minnow/util/arp_message.hh /tmp/minnow/util/checksum.hh /tmp/minnow/util/ethernet_frame.hh /tmp/minnow/util/ethernet_header.cc /tmp/minnow/util/ethernet_header.hh /tmp/minnow/util/eventloop.cc /tmp/minnow/util/eventloop.hh /tmp/minnow/util/exception.hh /tmp/minnow/util/fd_adapter.hh /tmp/minnow/util/file_descriptor.cc /tmp/minnow/util/file_descriptor.hh /tmp/minnow/util/ipv4_datagram.hh /tmp/minnow/util/ipv4_header.cc /tmp/minnow/util/ipv4_header.hh /tmp/minnow/util/lossy_fd_adapter.hh /tmp/minnow/util/parser.hh /tmp/minnow/util/random.cc /tmp/minnow/util/random.hh /tmp/minnow/util/socket.cc /tmp/minnow/util/socket.hh /tmp/minnow/util/tcp_config.hh /tmp/minnow/util/tcp_minnow_socket.hh /tmp/minnow/util/tcp_minnow_socket_impl.hh /tmp/minnow/util/tcp_over_ip.cc /tmp/minnow/util/tcp_over_ip.hh /tmp/minnow/util/tcp_peer.hh /tmp/minnow/util/tcp_receiver_message.hh /tmp/minnow/util/tcp_segment.cc /tmp/minnow/util/tcp_segment.hh /tmp/minnow/util/tcp_sender_message.hh /tmp/minnow/util/tun.cc /tmp/minnow/util/tun.hh /tmp/minnow/util/tuntap_adapter.cc /tmp/minnow/util/tuntap_adapter.hh /tmp/minnow/util/udinfo.hh

format: CMakeFiles/format
format: CMakeFiles/format.dir/build.make
.PHONY : format

# Rule to build all files generated by this target.
CMakeFiles/format.dir/build: format
.PHONY : CMakeFiles/format.dir/build

CMakeFiles/format.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/format.dir/cmake_clean.cmake
.PHONY : CMakeFiles/format.dir/clean

CMakeFiles/format.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/CMakeFiles/format.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/format.dir/depend

