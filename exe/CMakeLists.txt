add_executable(cpp_test_exe hello_test.cpp)

target_link_libraries(cpp_test_exe
    PRIVATE
        cpp_lib)

SetMyDefaultFlags(cpp_test_exe)

ConfigSanitizers(cpp_test_exe)

install(TARGETS cpp_test_exe
    EXPORT "cpp_test_exeExport"
    RUNTIME DESTINATION ${CMAKE_SOURCE_DIR}/install/bin
    LIBRARY DESTINATION ${CMAKE_SOURCE_DIR}/install/lib
    ARCHIVE DESTINATION ${CMAKE_SOURCE_DIR}/install/lib
)

# CMake config name, namespace and path
install(EXPORT "cpp_test_exeExport"
    FILE "cpp_test_exeTargets.cmake"
    NAMESPACE cmakescripts::
    DESTINATION ${CMAKE_SOURCE_DIR}/install/cmake
)
