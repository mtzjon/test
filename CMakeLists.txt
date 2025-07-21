cmake_minimum_required(VERSION 3.15)
project(cpp-docker-app VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# =============================================================================
# Find Dependencies
# =============================================================================

# Find Conan dependencies
find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)

# Find development tools
find_program(CLANG_FORMAT_EXECUTABLE clang-format)
find_program(CLANG_TIDY_EXECUTABLE clang-tidy)
find_package(Doxygen)

# =============================================================================
# Target Definition
# =============================================================================

# Add executable
add_executable(${PROJECT_NAME} 
    src/main.cpp
    src/app.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE include)

# Link libraries
target_link_libraries(${PROJECT_NAME} 
    fmt::fmt
    spdlog::spdlog
)

# Compiler-specific options
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4)
else()
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# =============================================================================
# Code Quality Tools
# =============================================================================

# Clang-Format
if(CLANG_FORMAT_EXECUTABLE)
    file(GLOB_RECURSE ALL_SOURCE_FILES 
        ${CMAKE_SOURCE_DIR}/src/*.cpp 
        ${CMAKE_SOURCE_DIR}/src/*.c
        ${CMAKE_SOURCE_DIR}/include/*.h 
        ${CMAKE_SOURCE_DIR}/include/*.hpp
    )
    
    add_custom_target(format
        COMMAND ${CLANG_FORMAT_EXECUTABLE} -i ${ALL_SOURCE_FILES}
        COMMENT "Formatting code with clang-format"
        VERBATIM
    )
    
    add_custom_target(format-check
        COMMAND ${CLANG_FORMAT_EXECUTABLE} --dry-run --Werror ${ALL_SOURCE_FILES}
        COMMENT "Checking code format with clang-format"
        VERBATIM
    )
    
    message(STATUS "Found clang-format: ${CLANG_FORMAT_EXECUTABLE}")
    message(STATUS "  - Run 'make format' to format code")
    message(STATUS "  - Run 'make format-check' to check formatting")
else()
    message(WARNING "clang-format not found")
endif()

# Clang-Tidy
if(CLANG_TIDY_EXECUTABLE)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        CXX_CLANG_TIDY "${CLANG_TIDY_EXECUTABLE};--config-file=${CMAKE_SOURCE_DIR}/.clang-tidy"
    )
    
    add_custom_target(tidy
        COMMAND ${CLANG_TIDY_EXECUTABLE} 
            --config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
            --header-filter='(src|include)/.*\.h(pp)?$'
            -p=${CMAKE_BINARY_DIR}
            ${ALL_SOURCE_FILES}
        COMMENT "Running clang-tidy analysis"
        VERBATIM
    )
    
    add_custom_target(tidy-fix
        COMMAND ${CLANG_TIDY_EXECUTABLE} 
            --config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
            --header-filter='(src|include)/.*\.h(pp)?$'
            -p=${CMAKE_BINARY_DIR}
            --fix
            ${ALL_SOURCE_FILES}
        COMMENT "Running clang-tidy with automatic fixes"
        VERBATIM
    )
    
    message(STATUS "Found clang-tidy: ${CLANG_TIDY_EXECUTABLE}")
    message(STATUS "  - Run 'make tidy' to run static analysis")
    message(STATUS "  - Run 'make tidy-fix' to apply automatic fixes")
else()
    message(WARNING "clang-tidy not found")
endif()

# =============================================================================
# Documentation Generation
# =============================================================================

if(DOXYGEN_FOUND)
    # Configure Doxygen
    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
    
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    
    add_custom_target(docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating documentation with Doxygen"
        VERBATIM
    )
    
    add_custom_target(docs-open
        COMMAND ${CMAKE_COMMAND} -E echo "Opening documentation..."
        COMMAND xdg-open ${CMAKE_CURRENT_BINARY_DIR}/docs/html/index.html || 
                open ${CMAKE_CURRENT_BINARY_DIR}/docs/html/index.html || 
                start ${CMAKE_CURRENT_BINARY_DIR}/docs/html/index.html
        DEPENDS docs
        COMMENT "Opening generated documentation in browser"
        VERBATIM
    )
    
    message(STATUS "Found Doxygen: ${DOXYGEN_EXECUTABLE}")
    message(STATUS "  - Run 'make docs' to generate documentation")
    message(STATUS "  - Run 'make docs-open' to generate and open documentation")
else()
    message(WARNING "Doxygen not found - documentation target not available")
endif()

# =============================================================================
# Custom Targets for Development Workflow
# =============================================================================

# All-in-one quality check
add_custom_target(quality-check
    DEPENDS format-check tidy
    COMMENT "Running all code quality checks"
)

# All-in-one format and fix
if(CLANG_FORMAT_EXECUTABLE AND CLANG_TIDY_EXECUTABLE)
    add_custom_target(format-and-fix
        DEPENDS format tidy-fix
        COMMENT "Formatting code and applying automatic fixes"
    )
endif()

# Print configuration summary
message(STATUS "")
message(STATUS "=== C++ Docker App Configuration Summary ===")
message(STATUS "Project: ${PROJECT_NAME} v${PROJECT_VERSION}")
message(STATUS "C++ Standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")
message(STATUS "Available targets:")
message(STATUS "  - ${PROJECT_NAME}     : Build the application")
if(CLANG_FORMAT_EXECUTABLE)
    message(STATUS "  - format          : Format source code")
    message(STATUS "  - format-check    : Check code formatting")
endif()
if(CLANG_TIDY_EXECUTABLE)
    message(STATUS "  - tidy            : Run static analysis")
    message(STATUS "  - tidy-fix        : Apply automatic fixes")
endif()
if(DOXYGEN_FOUND)
    message(STATUS "  - docs            : Generate documentation")
    message(STATUS "  - docs-open       : Generate and open docs")
endif()
message(STATUS "  - quality-check   : Run all quality checks")
if(CLANG_FORMAT_EXECUTABLE AND CLANG_TIDY_EXECUTABLE)
    message(STATUS "  - format-and-fix  : Format and fix code")
endif()
message(STATUS "===============================================")
message(STATUS "")