add_library(cpp_lib SHARED hello_lib.cpp)

SetMyDefaultFlags(cpp_lib)

target_sources(cpp_lib
    PUBLIC
        FILE_SET HEADERS
        BASE_DIRS ${PROJECT_SOURCE_DIR}
        FILES
            hello_lib.hpp
)

install(TARGETS cpp_lib
    EXPORT "cpp_libExport"
    RUNTIME DESTINATION ${CMAKE_SOURCE_DIR}/install/bin
    LIBRARY DESTINATION ${CMAKE_SOURCE_DIR}/install/lib
    ARCHIVE DESTINATION ${CMAKE_SOURCE_DIR}/install/lib
    FILE_SET HEADERS
    DESTINATION ${CMAKE_SOURCE_DIR}/install/include
)

# CMake config name, namespace and path
install(EXPORT "cpp_libExport"
    FILE "cpp_libTargets.cmake"
    NAMESPACE cmakescripts::
    DESTINATION ${CMAKE_SOURCE_DIR}/install/cmake
)
