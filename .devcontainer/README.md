# VS Code Dev Container for C++ Development

This dev container provides a complete C++ development environment with CMake and Conan support.

## Features

- **Ubuntu 22.04** base image
- **C++ development tools**: GCC, Clang, CMake, Ninja
- **Debugging tools**: GDB, LLDB, Valgrind
- **Code analysis**: Clang-format, Clang-tidy, Cppcheck
- **Conan package manager** pre-installed and configured
- **VS Code extensions** for C++ development automatically installed

## Getting Started

1. **Prerequisites**: Ensure you have VS Code with the Dev Containers extension installed
2. **Open in container**: When you open this workspace in VS Code, you'll be prompted to reopen in container
3. **Automatic setup**: The container will automatically run `conan install` and configure CMake

## Available VS Code Tasks

- **Conan Install**: Install dependencies using Conan
- **CMake Configure**: Configure the project with CMake
- **CMake Build**: Build the project (default build task - Ctrl+Shift+P → "Tasks: Run Build Task")
- **Run Application**: Build and run the application
- **Clean Build**: Clean the build directory

## Debugging

Two debug configurations are available:
- **Debug C++ Application**: Uses GDB for debugging
- **Debug with LLDB**: Uses LLDB for debugging

Both configurations will automatically build the project before debugging.

## CMake Presets

The project includes CMake presets for easy configuration:
- `default`: Debug configuration
- `release`: Release configuration

Use them with: `cmake --preset default` or `cmake --preset release`

## Development Workflow

1. Open the project in VS Code dev container
2. Make your code changes
3. Press `Ctrl+Shift+P` and run "Tasks: Run Build Task" to build
4. Press `F5` to debug your application
5. Use the integrated terminal for any additional commands

## Extensions Included

- C/C++ Extension Pack
- CMake Tools
- CMake syntax highlighting
- Better C++ syntax
- Python (for Conan)
- Code Runner
- LLDB debugger
- GitHub Copilot (optional)

The development environment is fully configured and ready to use!