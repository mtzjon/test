/**
 * @file app.h
 * @brief Main application class definition
 * @author C++ Docker Project Team
 * @date 2024
 * @version 1.0.0
 * 
 * This header file contains the definition of the main App class which
 * provides the core functionality for the C++ Docker application.
 */

#pragma once

#include <string>

/**
 * @class App
 * @brief Main application class that handles program execution
 * 
 * The App class encapsulates the main functionality of the application,
 * including initialization, execution, and cleanup phases. It demonstrates
 * the use of modern C++ features along with external libraries like fmt
 * and spdlog for formatting and logging respectively.
 * 
 * @section usage Usage Example
 * @code{.cpp}
 * App app;
 * app.run();
 * @endcode
 * 
 * @note This class follows RAII principles with proper initialization
 *       in the constructor and cleanup in the destructor.
 */
class App {
public:
    /**
     * @brief Default constructor
     * 
     * Initializes the application by calling the initialize() method.
     * Sets up any necessary resources and prepares the application for execution.
     * 
     * @see initialize()
     */
    App();
    
    /**
     * @brief Destructor
     * 
     * Cleans up the application by calling the cleanup() method.
     * Ensures proper resource deallocation following RAII principles.
     * 
     * @see cleanup()
     */
    ~App();
    
    /**
     * @brief Main execution method
     * 
     * Runs the primary application logic including greeting messages
     * and demonstration of formatting capabilities. This is the main
     * entry point for application functionality after initialization.
     * 
     * @throws std::exception May throw if logging or formatting operations fail
     * 
     * @see greet()
     */
    void run();
    
    /**
     * @brief Displays a formatted greeting message
     * 
     * Creates and displays a greeting message using the fmt library for
     * formatting and spdlog for logging. The message is both logged and
     * printed to standard output.
     * 
     * @param name The name to include in the greeting message
     * 
     * @pre name should be a valid string (not empty recommended)
     * @post A greeting message is logged and printed
     * 
     * @code{.cpp}
     * app.greet("World");  // Outputs: "Hello, World!"
     * @endcode
     */
    void greet(const std::string& name);
    
private:
    /**
     * @brief Initializes application resources
     * 
     * Performs necessary initialization steps for the application.
     * This method is called automatically by the constructor.
     * 
     * @note This is a private method used internally by the class
     */
    void initialize();
    
    /**
     * @brief Cleans up application resources
     * 
     * Performs cleanup operations and resource deallocation.
     * This method is called automatically by the destructor.
     * 
     * @note This is a private method used internally by the class
     */
    void cleanup();
};