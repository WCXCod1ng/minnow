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

# Include any dependencies generated for this target.
include tests/CMakeFiles/reassembler_speed_test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/reassembler_speed_test.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/reassembler_speed_test.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/reassembler_speed_test.dir/flags.make

tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o: tests/CMakeFiles/reassembler_speed_test.dir/flags.make
tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o: /tmp/minnow/tests/reassembler_speed_test.cc
tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o: tests/CMakeFiles/reassembler_speed_test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o -MF CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o.d -o CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o -c /tmp/minnow/tests/reassembler_speed_test.cc

tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.i"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/minnow/tests/reassembler_speed_test.cc > CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.i

tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.s"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/minnow/tests/reassembler_speed_test.cc -o CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.s

# Object files for target reassembler_speed_test
reassembler_speed_test_OBJECTS = \
"CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o"

# External object files for target reassembler_speed_test
reassembler_speed_test_EXTERNAL_OBJECTS =

tests/reassembler_speed_test: tests/CMakeFiles/reassembler_speed_test.dir/reassembler_speed_test.cc.o
tests/reassembler_speed_test: tests/CMakeFiles/reassembler_speed_test.dir/build.make
tests/reassembler_speed_test: src/libminnow_optimized.a
tests/reassembler_speed_test: util/libutil_optimized.a
tests/reassembler_speed_test: tests/CMakeFiles/reassembler_speed_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable reassembler_speed_test"
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/reassembler_speed_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/reassembler_speed_test.dir/build: tests/reassembler_speed_test
.PHONY : tests/CMakeFiles/reassembler_speed_test.dir/build

tests/CMakeFiles/reassembler_speed_test.dir/clean:
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -P CMakeFiles/reassembler_speed_test.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/reassembler_speed_test.dir/clean

tests/CMakeFiles/reassembler_speed_test.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow/tests /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/tests /tmp/minnow/cmake-build-debug-docker/tests/CMakeFiles/reassembler_speed_test.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/CMakeFiles/reassembler_speed_test.dir/depend

