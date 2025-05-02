function(DeployLibs target_file_path deps_install_directory optional_add_dirs optional_ignore_dirs)

install(CODE "set(DEPS_DIRECTORY \"${CMAKE_INSTALL_PREFIX}/bin/${INSTALL_COMBINATION}\")")
install(CODE "set(TARGET_FILE \"${target_file_path}\")")

if (WIN32)
    

    set(MY_DEPENDENCY_PATHS
        "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/bin"
        "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/bin"
        "C:/msys64/mingw64/bin"
    )
    install(CODE "set(MY_DEPENDENCY_PATHS \"${MY_DEPENDENCY_PATHS}\")")

else ()
    install(CODE "set(DEPS_DIRECTORY \"${CMAKE_INSTALL_PREFIX}/lib/${INSTALL_COMBINATION}\")")
    install(CODE "set(TARGET_FILE \"${CMAKE_CURRENT_BINARY_DIR}/${LIBONDAS_TARGET_NAME}.so\")")
endif ()

install(CODE [[
    file(GET_RUNTIME_DEPENDENCIES
        EXECUTABLES "${TARGET_FILE}"
        RESOLVED_DEPENDENCIES_VAR RESOLVED_DEPS
        UNRESOLVED_DEPENDENCIES_VAR UNRESOLVED_DEPS
        DIRECTORIES ${MY_DEPENDENCY_PATHS}
        POST_EXCLUDE_REGEXES
            "/DatabridgeNeo/"
    )
    foreach(FILE ${RESOLVED_DEPS})
        file(INSTALL
            DESTINATION "${DEPS_DIRECTORY}"
            TYPE SHARED_LIBRARY
            FOLLOW_SYMLINK_CHAIN
            FILES "${FILE}"
        )
    endforeach()
    foreach(FILE ${UNRESOLVED_DEPS})
        message(WARN  " Unresolved: ${FILE}")
    endforeach()
]])
endfunction()

function(CreateUninstaller)
    if(NOT TARGET uninstall)
        configure_file(
                "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
                "${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake"
                IMMEDIATE @ONLY
        )

        add_custom_target(uninstall
                COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake
        )
    endif()
endfunction()