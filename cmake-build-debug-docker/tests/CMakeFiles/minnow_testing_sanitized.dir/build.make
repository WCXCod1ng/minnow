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
include tests/CMakeFiles/minnow_testing_sanitized.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/minnow_testing_sanitized.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/minnow_testing_sanitized.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/minnow_testing_sanitized.dir/flags.make

tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o: tests/CMakeFiles/minnow_testing_sanitized.dir/flags.make
tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o: /tmp/minnow/tests/common.cc
tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o: tests/CMakeFiles/minnow_testing_sanitized.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o -MF CMakeFiles/minnow_testing_sanitized.dir/common.cc.o.d -o CMakeFiles/minnow_testing_sanitized.dir/common.cc.o -c /tmp/minnow/tests/common.cc

tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/minnow_testing_sanitized.dir/common.cc.i"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/minnow/tests/common.cc > CMakeFiles/minnow_testing_sanitized.dir/common.cc.i

tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/minnow_testing_sanitized.dir/common.cc.s"
	cd /tmp/minnow/cmake-build-debug-docker/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/minnow/tests/common.cc -o CMakeFiles/minnow_testing_sanitized.dir/common.cc.s

# Object files for target minnow_testing_sanitized
minnow_testing_sanitized_OBJECTS = \
"CMakeFiles/minnow_testing_sanitized.dir/common.cc.o"

# External object files for target minnow_testing_sanitized
minnow_testing_sanitized_EXTERNAL_OBJECTS =

tests/libminnow_testing_sanitized.a: tests/CMakeFiles/minnow_testing_sanitized.dir/common.cc.o
tests/libminnow_testing_sanitized.a: tests/CMakeFiles/minnow_testing_sanitized.dir/build.make
tests/libminnow_testing_sanitized.a: tests/CMakeFiles/minnow_testing_sanitized.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/tmp/minnow/cmake-build-debug-docker/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libminnow_testing_sanitized.a"
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -P CMakeFiles/minnow_testing_sanitized.dir/cmake_clean_target.cmake
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/minnow_testing_sanitized.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/minnow_testing_sanitized.dir/build: tests/libminnow_testing_sanitized.a
.PHONY : tests/CMakeFiles/minnow_testing_sanitized.dir/build

tests/CMakeFiles/minnow_testing_sanitized.dir/clean:
	cd /tmp/minnow/cmake-build-debug-docker/tests && $(CMAKE_COMMAND) -P CMakeFiles/minnow_testing_sanitized.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/minnow_testing_sanitized.dir/clean

tests/CMakeFiles/minnow_testing_sanitized.dir/depend:
	cd /tmp/minnow/cmake-build-debug-docker && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/minnow /tmp/minnow/tests /tmp/minnow/cmake-build-debug-docker /tmp/minnow/cmake-build-debug-docker/tests /tmp/minnow/cmake-build-debug-docker/tests/CMakeFiles/minnow_testing_sanitized.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/CMakeFiles/minnow_testing_sanitized.dir/depend

