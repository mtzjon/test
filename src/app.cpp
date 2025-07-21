/**
 * @file app.cpp
 * @brief Implementation of the main application class
 * @author C++ Docker Project Team
 * @date 2024
 * @version 1.0.0
 * 
 * This file contains the implementation of the App class methods defined
 * in app.h. It demonstrates the use of modern C++ features with external
 * libraries for logging and string formatting.
 */

#include "app.h"
#include <fmt/format.h>
#include <spdlog/spdlog.h>
#include <iostream>

App::App() {
    initialize();
}

App::~App() {
    cleanup();
}

void App::initialize() {
    spdlog::info("Initializing application...");
    // Additional initialization logic can be added here
    // such as configuration loading, resource allocation, etc.
}

void App::cleanup() {
    spdlog::info("Cleaning up application...");
    // Additional cleanup logic can be added here
    // such as resource deallocation, cache clearing, etc.
}

void App::run() {
    spdlog::info("Starting C++ Docker application");
    
    // Demonstrate greeting functionality
    greet("Docker World");
    greet("Conan Package Manager");
    
    // Demo some functionality with formatted output
    for (int i = 1; i <= 5; ++i) {
        const auto message = fmt::format("Processing item #{}", i);
        spdlog::info(message);
    }
    
    spdlog::info("Application completed successfully");
}

void App::greet(const std::string& name) {
    // Use fmt library for string formatting
    const auto greeting = fmt::format("Hello, {}!", name);
    
    // Log the greeting using spdlog
    spdlog::info(greeting);
    
    // Also output to console
    std::cout << greeting << std::endl;
}