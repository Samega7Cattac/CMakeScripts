function(LinkCompileCommands directory)
    # Generate a compile_commands.json file
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

    # Create symlink to compile_commands.json for IDE to pick it up
    if (PROJECT_IS_TOP_LEVEL AND UNIX)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink
            ${CMAKE_BINARY_DIR}/compile_commands.json
            ${directory}/compile_commands.json
    )
    endif()
endfunction()
