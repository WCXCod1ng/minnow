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
include tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/flags.make

tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o: tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/flags.make
tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o: /tmp/minnow/tests/byte_stream_stress_test.cc
tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o: tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o -MF CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o.d -o CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o -c /tmp/minnow/tests/byte_stream_stress_test.cc

tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.i"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/minnow/tests/byte_stream_stress_test.cc > CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.i

tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.s"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/minnow/tests/byte_stream_stress_test.cc -o CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.s

# Object files for target byte_stream_stress_test_sanitized
byte_stream_stress_test_sanitized_OBJECTS = \
"CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o"

# External object files for target byte_stream_stress_test_sanitized
byte_stream_stress_test_sanitized_EXTERNAL_OBJECTS =

tests/byte_stream_stress_test_sanitized: tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/byte_stream_stress_test.cc.o
tests/byte_stream_stress_test_sanitized: tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/build.make
tests/byte_stream_stress_test_sanitized: tests/libminnow_testing_sanitized.a
tests/byte_stream_stress_test_sanitized: src/libminnow_sanitized.a
tests/byte_stream_stress_test_sanitized: util/libutil_sanitized.a
tests/byte_stream_stress_test_sanitized: tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable byte_stream_stress_test_sanitized"
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/byte_stream_stress_test_sanitized.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/build: tests/byte_stream_stress_test_sanitized
.PHONY : tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/build

tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/clean:
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -P CMakeFiles/byte_stream_stress_test_sanitized.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/clean

tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow/tests /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/tests /tmp/minnow/cmake-build-debug-docker/tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/CMakeFiles/byte_stream_stress_test_sanitized.dir/depend

