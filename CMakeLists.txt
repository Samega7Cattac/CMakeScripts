cmake_minimum_required(VERSION 3.23)

# Set to "ON" to debug makefile commands
set(CMAKE_VERBOSE_MAKEFILE ON
	CACHE BOOL "Show makefiles commands on build"
)

project(CMakeScriptsTest
    VERSION 1.0
    LANGUAGES C CXX)

enable_testing()

include(integration.cmake)
include(cpp_flags.cmake)
include(gcc_sanitizers.cmake)
include(install.cmake)

add_subdirectory(lib)
add_subdirectory(exe)

add_test(NAME TestCppExe COMMAND cpp_test_exe)

CreateUninstaller()
