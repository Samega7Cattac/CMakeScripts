set(ENABLE_GCC_ADDRESS_SANITIZER OFF CACHE BOOL "Enable gcc address sanitizer")
set(ENABLE_GCC_UNDEFINED_SANITIZER OFF CACHE BOOL "Enable gcc undefined sanitizer")
set(ENABLE_GCC_LEAK_SANITIZER OFF CACHE BOOL "Enable gcc leak sanitizer")

function(SetAddressSanitizer enabled)
    set(ENABLE_GCC_ADDRESS_SANITIZER ${enabled})
endfunction()

function(SetUndefinedSanitizer enabled)
    set(ENABLE_GCC_UNDEFINED_SANITIZER ${enabled})
endfunction()

function(SetLeakSanitizer enabled)
    set(ENABLE_GCC_LEAK_SANITIZER ${enabled})
endfunction()

function(ConfigSanitizers target_name)
    if (${ENABLE_GCC_ADDRESS_SANITIZER})
        target_compile_options(${target_name}
            PRIVATE
                -fsanitize=address
        )
        
        target_link_options(${target_name}
            PRIVATE
                -fsanitize=address
        )
    endif ()

    if (${ENABLE_GCC_UNDEFINED_SANITIZER})
        target_compile_options(${target_name}
            PRIVATE
                -fsanitize=undefined
        )
        
        target_link_options(${target_name}
            PRIVATE
                -fsanitize=undefined
        )
    endif ()

    if (${ENABLE_GCC_LEAK_SANITIZER})
        target_compile_options(${target_name}
            PRIVATE
                -fsanitize=leak
        )
        
        target_link_options(${target_name}
            PRIVATE
                -fsanitize=leak
        )
    endif ()

endfunction()