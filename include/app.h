#pragma once

#include <string>

class App {
public:
    App();
    ~App();
    
    void run();
    void greet(const std::string& name);
    
private:
    void initialize();
    void cleanup();
};