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
}

void App::cleanup() {
    spdlog::info("Cleaning up application...");
}

void App::run() {
    spdlog::info("Starting C++ Docker application");
    
    greet("Docker World");
    greet("Conan Package Manager");
    
    // Demo some functionality
    for (int i = 1; i <= 5; ++i) {
        auto message = fmt::format("Processing item #{}", i);
        spdlog::info(message);
    }
    
    spdlog::info("Application completed successfully");
}

void App::greet(const std::string& name) {
    auto greeting = fmt::format("Hello, {}!", name);
    spdlog::info(greeting);
    std::cout << greeting << std::endl;
}