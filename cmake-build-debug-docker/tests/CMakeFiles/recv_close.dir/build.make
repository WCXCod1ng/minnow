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
include tests/CMakeFiles/recv_close.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/recv_close.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/recv_close.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/recv_close.dir/flags.make

tests/CMakeFiles/recv_close.dir/recv_close.cc.o: tests/CMakeFiles/recv_close.dir/flags.make
tests/CMakeFiles/recv_close.dir/recv_close.cc.o: /tmp/minnow/tests/recv_close.cc
tests/CMakeFiles/recv_close.dir/recv_close.cc.o: tests/CMakeFiles/recv_close.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/recv_close.dir/recv_close.cc.o"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests/CMakeFiles/recv_close.dir/recv_close.cc.o -MF CMakeFiles/recv_close.dir/recv_close.cc.o.d -o CMakeFiles/recv_close.dir/recv_close.cc.o -c /tmp/minnow/tests/recv_close.cc

tests/CMakeFiles/recv_close.dir/recv_close.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/recv_close.dir/recv_close.cc.i"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/minnow/tests/recv_close.cc > CMakeFiles/recv_close.dir/recv_close.cc.i

tests/CMakeFiles/recv_close.dir/recv_close.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/recv_close.dir/recv_close.cc.s"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/minnow/tests/recv_close.cc -o CMakeFiles/recv_close.dir/recv_close.cc.s

# Object files for target recv_close
recv_close_OBJECTS = \
"CMakeFiles/recv_close.dir/recv_close.cc.o"

# External object files for target recv_close
recv_close_EXTERNAL_OBJECTS =

tests/recv_close: tests/CMakeFiles/recv_close.dir/recv_close.cc.o
tests/recv_close: tests/CMakeFiles/recv_close.dir/build.make
tests/recv_close: tests/libminnow_testing_debug.a
tests/recv_close: src/libminnow_debug.a
tests/recv_close: util/libutil_debug.a
tests/recv_close: tests/CMakeFiles/recv_close.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable recv_close"
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/recv_close.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/recv_close.dir/build: tests/recv_close
.PHONY : tests/CMakeFiles/recv_close.dir/build

tests/CMakeFiles/recv_close.dir/clean:
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -P CMakeFiles/recv_close.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/recv_close.dir/clean

tests/CMakeFiles/recv_close.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow/tests /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/tests /tmp/minnow/cmake-build-debug-docker/tests/CMakeFiles/recv_close.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/CMakeFiles/recv_close.dir/depend

