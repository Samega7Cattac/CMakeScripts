function(SetCppStandards cpp_minimum default_extensions)
    if (DEFINED CMAKE_CXX_STANDARD)
        if (NOT CMAKE_CXX_STANDARD EQUAL ${cpp_minimum})
            if (CMAKE_CXX_STANDARD EQUAL 98 OR CMAKE_CXX_STANDARD LESS ${cpp_minimum})
                message (FATAL_ERROR "This project requires at least C++ ${cpp_minimum}")
            endif ()
        endif ()
    else ()
        set (CMAKE_CXX_STANDARD ${cpp_minimum})
    endif ()

    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    if (NOT DEFINED CMAKE_CXX_EXTENSIONS)
        set(CMAKE_CXX_EXTENSIONS ${default_extensions})
    endif ()
endfunction()

function(SetMyDefaultFlags target_name)
    # General warning and debugging options (applied to all configurations)
    target_compile_options(${target_name}
        PRIVATE
            -Werror                 # Treat all warnings as errors
            -Wall                   # Enables all standard warnings
            -Wextra                 # Enables extra warnings
            -Wpedantic              # Enforces strict ISO C++ rules
            -Wshadow                # Warns about variable shadowing
            -Wnon-virtual-dtor      # Warns if a class with virtual functions has a non-virtual destructor
            -Wold-style-cast        # Warns about old-style casts
            -Wcast-align            # Warns about pointer casts that may result in misalignment
            -Wunused                # Warns about unused variables and functions
            -Woverloaded-virtual    # Warns about virtual functions that are overloaded
            -Wconversion            # Warns about implicit type conversions that may change a value
            -Wsign-conversion       # Warns about conversions between signed and unsigned integers
            -Wnull-dereference      # Warns about potential null pointer dereferences
            -Wdouble-promotion      # Warns about float to double promotions
            -Wformat=2              # Enables additional format string warnings
            $<$<CONFIG:DEBUG>:
                -g                          # Generates debugging information
                -O0                         # Disables optimizations for debugging
                -D_GLIBCXX_ASSERTIONS       # Conditionally enable libstdc++ assertions
                -D_GLIBCXX_DEBUG            # Conditionally enable libstdc++ debug checks
                -D_GLIBCXX_DEBUG_PEDANTIC   # Conditionally enable libstdc++ pedantic debug checks
                -fno-omit-frame-pointer     # Ensures frame pointers are not omitted for better debugging
            >
            $<$<CONFIG:RELEASE>:
                -O3             # Enables optimization level 3
                -DNDEBUG        # Disables debugging macros
                -fno-rtti       # Disables runtime type information
                -fno-math-errno
                -fno-trapping-math
                # -ffast-math       # Optimize math function, may break IEE745
                # -march=native     # Optimizes to current hardware
            >
    )

    if (${CMAKE_BUILD_TYPE} STREQUAL "Release")
        target_link_options(${target_name}
            PRIVATE
                -Wl,-O1              # Optimizes linker options
                -Wl,--sort-common    # Sorts common symbols
                -Wl,--as-needed      # Links only necessary libraries
                -Wl,--gc-sections    # Removes unused sections
        )

        include(CheckIPOSupported)
        check_ipo_supported(RESULT supported OUTPUT error)
        if (supported)
            # message(STATUS "IPO / LTO enabled")
            set_property(TARGET ${target_name} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
        # else()
        #     message(STATUS "IPO / LTO not supported: <${error}>")
        endif()
    endif ()
endfunction()