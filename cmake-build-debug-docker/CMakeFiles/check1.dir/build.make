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

# Utility rule file for check1.

# Include any custom commands dependencies for this target.
include CMakeFiles/check1.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/check1.dir/progress.make

CMakeFiles/check1:
	/usr/bin/ctest --output-on-failure --stop-on-failure --timeout 12 -R '^byte_stream_|^reassembler_'

check1: CMakeFiles/check1
check1: CMakeFiles/check1.dir/build.make
.PHONY : check1

# Rule to build all files generated by this target.
CMakeFiles/check1.dir/build: check1
.PHONY : CMakeFiles/check1.dir/build

CMakeFiles/check1.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/check1.dir/cmake_clean.cmake
.PHONY : CMakeFiles/check1.dir/clean

CMakeFiles/check1.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/CMakeFiles/check1.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/check1.dir/depend

