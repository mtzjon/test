#include "app.h"
#include <spdlog/spdlog.h>
#include <exception>

int main() {
    try {
        spdlog::set_level(spdlog::level::info);
        spdlog::info("=== C++ Docker Application ===");
        
        App app;
        app.run();
        
        return 0;
    }
    catch (const std::exception& e) {
        spdlog::error("Application error: {}", e.what());
        return 1;
    }
    catch (...) {
        spdlog::error("Unknown error occurred");
        return 1;
    }
}