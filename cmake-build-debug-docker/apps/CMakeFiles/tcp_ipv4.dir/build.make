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
include apps/CMakeFiles/tcp_ipv4.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include apps/CMakeFiles/tcp_ipv4.dir/compiler_depend.make

# Include the progress variables for this target.
include apps/CMakeFiles/tcp_ipv4.dir/progress.make

# Include the compile flags for this target's objects.
include apps/CMakeFiles/tcp_ipv4.dir/flags.make

apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o: apps/CMakeFiles/tcp_ipv4.dir/flags.make
apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o: /tmp/minnow/apps/tcp_ipv4.cc
apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o: apps/CMakeFiles/tcp_ipv4.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o"
	cd /tmp/minnow/cmake-build-debug-docker/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o -MF CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o.d -o CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o -c /tmp/minnow/apps/tcp_ipv4.cc

apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.i"
	cd /tmp/minnow/cmake-build-debug-docker/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/minnow/apps/tcp_ipv4.cc > CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.i

apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.s"
	cd /tmp/minnow/cmake-build-debug-docker/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/minnow/apps/tcp_ipv4.cc -o CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.s

# Object files for target tcp_ipv4
tcp_ipv4_OBJECTS = \
"CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o"

# External object files for target tcp_ipv4
tcp_ipv4_EXTERNAL_OBJECTS =

apps/tcp_ipv4: apps/CMakeFiles/tcp_ipv4.dir/tcp_ipv4.cc.o
apps/tcp_ipv4: apps/CMakeFiles/tcp_ipv4.dir/build.make
apps/tcp_ipv4: apps/libstream_copy.a
apps/tcp_ipv4: src/libminnow_debug.a
apps/tcp_ipv4: util/libutil_debug.a
apps/tcp_ipv4: apps/CMakeFiles/tcp_ipv4.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable tcp_ipv4"
	cd /tmp/minnow/cmake-build-debug-docker/apps && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tcp_ipv4.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/CMakeFiles/tcp_ipv4.dir/build: apps/tcp_ipv4
.PHONY : apps/CMakeFiles/tcp_ipv4.dir/build

apps/CMakeFiles/tcp_ipv4.dir/clean:
	cd /tmp/minnow/cmake-build-debug-docker/apps && $(CMAKE_COMMAND) -P CMakeFiles/tcp_ipv4.dir/cmake_clean.cmake
.PHONY : apps/CMakeFiles/tcp_ipv4.dir/clean

apps/CMakeFiles/tcp_ipv4.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow/apps /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/apps /tmp/minnow/cmake-build-debug-docker/apps/CMakeFiles/tcp_ipv4.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : apps/CMakeFiles/tcp_ipv4.dir/depend

