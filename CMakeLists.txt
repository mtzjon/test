cmake_minimum_required(VERSION 3.15)
project(cpp-docker-app VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Conan dependencies
find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)

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