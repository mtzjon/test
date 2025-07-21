/**
 * @file main.cpp
 * @brief Application entry point
 * @author C++ Docker Project Team
 * @date 2024
 * @version 1.0.0
 * 
 * This file contains the main function which serves as the entry point
 * for the C++ Docker application. It demonstrates proper error handling
 * and logging setup for a modern C++ application.
 */

#include "app.h"
#include <spdlog/spdlog.h>
#include <exception>

/**
 * @brief Main entry point for the application
 * 
 * Initializes logging, creates an App instance, and executes the main
 * application logic. Includes comprehensive error handling for both
 * known exceptions and unknown errors.
 * 
 * The function sets up spdlog with info level logging and handles any
 * exceptions that might occur during application execution.
 * 
 * @return int Exit code (0 for success, 1 for error)
 * @retval 0 Application completed successfully
 * @retval 1 An error occurred during execution
 * 
 * @note This function uses structured exception handling to ensure
 *       proper error reporting and graceful application termination.
 * 
 * @see App::run()
 */
int main() {
    try {
        // Configure logging level
        spdlog::set_level(spdlog::level::info);
        spdlog::info("=== C++ Docker Application ===");
        
        // Create and run the application
        App app;
        app.run();
        
        return 0;
    }
    catch (const std::exception& e) {
        // Handle known exceptions
        spdlog::error("Application error: {}", e.what());
        return 1;
    }
    catch (...) {
        // Handle unknown exceptions
        spdlog::error("Unknown error occurred");
        return 1;
    }
}