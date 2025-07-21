# VS Code Dev Container for C++ Development

This dev container provides a complete C++ development environment with CMake, Conan support, and integrated code quality tools for modern C++ development.

## 🚀 Features

- **Ubuntu 22.04** base image
- **C++ development tools**: GCC, Clang, CMake, Ninja
- **Debugging tools**: GDB, LLDB, Valgrind
- **Code quality tools**: clang-format, clang-tidy, cppcheck
- **Documentation**: Doxygen with Graphviz support
- **Conan package manager** pre-installed and configured
- **VS Code extensions** for C++ development automatically installed

## 🛠️ Code Quality Integration

### Formatting and Linting
- **clang-format**: Automatic code formatting
- **clang-tidy**: Static analysis and modern C++ suggestions  
- **cppcheck**: Additional static analysis
- **Integration**: Pre-configured with VS Code for real-time feedback

### Documentation Generation
- **Doxygen**: API documentation generation
- **Graphviz**: Diagram generation for documentation
- **Live preview**: Generate and view documentation within VS Code

### Quality Workflow
- **Pre-commit hooks**: Automatic formatting and linting
- **VS Code tasks**: One-click quality checks
- **Command palette**: Quick access to all tools

## 📋 Getting Started

1. **Prerequisites**: Ensure you have VS Code with the Dev Containers extension installed
2. **Open in container**: When you open this workspace in VS Code, you'll be prompted to reopen in container
3. **Automatic setup**: The container will automatically run `conan install` and configure CMake

## 🔧 Available VS Code Tasks

### Build Tasks
- **Conan Install**: Install dependencies using Conan
- **CMake Configure**: Configure the project with CMake
- **CMake Build**: Build the project (default build task - Ctrl+Shift+P → "Tasks: Run Build Task")
- **Run Application**: Build and run the application
- **Clean Build**: Clean the build directory

### Code Quality Tasks
- **Format Code**: Format all source files with clang-format
- **Check Format**: Verify code formatting compliance
- **Run Linter**: Execute clang-tidy static analysis
- **Fix Linting Issues**: Apply automatic clang-tidy fixes
- **Check All Quality**: Run all code quality checks
- **Fix All Issues**: Apply all automatic fixes

### Documentation Tasks
- **Generate Documentation**: Create API documentation with Doxygen
- **Open Documentation**: Generate and open documentation in browser
- **Preview Documentation**: Live preview of documentation changes

## 🐛 Debugging

Multiple debug configurations are available:
- **Debug C++ Application**: Uses GDB for debugging
- **Debug with LLDB**: Uses LLDB for debugging
- **Debug with Valgrind**: Memory debugging with Valgrind

All configurations will automatically build the project before debugging.

## ⚙️ CMake Presets

The project includes CMake presets for easy configuration:
- `default`: Debug configuration with code quality tools enabled
- `release`: Release configuration optimized for production

Use them with: `cmake --preset default` or `cmake --preset release`

## 🔄 Development Workflow

### Quick Start Workflow
1. Open the project in VS Code dev container
2. Let the container initialize (Conan install, CMake configure)
3. Make your code changes
4. Press `Ctrl+Shift+P` and run "Tasks: Run Build Task" to build
5. Press `F5` to debug your application

### Code Quality Workflow
1. **Write code** with real-time formatting and linting feedback
2. **Format on save** automatically applies clang-format
3. **Fix issues** using VS Code quick fixes from clang-tidy
4. **Run quality checks** before committing:
   ```bash
   # Using VS Code Command Palette (Ctrl+Shift+P)
   > Tasks: Run Task → Check All Quality
   
   # Or using terminal
   ./scripts/code-quality.sh check-all
   ```

### Documentation Workflow
1. **Write Doxygen comments** as you code
2. **Generate documentation** regularly to verify completeness
3. **Preview changes** using the documentation tasks
4. **Deploy documentation** as part of your CI/CD pipeline

## 🧩 Extensions Included

### Core C++ Development
- **C/C++ Extension Pack**: Microsoft's complete C++ tooling
- **CMake Tools**: CMake integration with VS Code
- **CMake syntax highlighting**: Better CMake file support

### Code Quality
- **clang-format**: Automatic code formatting
- **Clang-Tidy**: Static analysis integration
- **Better C++ Syntax**: Enhanced C++ syntax highlighting
- **Code Runner**: Quick code execution

### Development Tools
- **Python**: For Conan and build scripts
- **LLDB Debugger**: Advanced debugging capabilities
- **GitHub Copilot**: AI-powered code completion (optional)
- **GitLens**: Enhanced Git integration

### Documentation
- **Better Comments**: Enhanced comment highlighting
- **Doxygen Documentation Generator**: Quick documentation templates

## ⚡ VS Code Settings

The dev container includes optimized settings for C++ development:

### Code Formatting
- **Format on save**: Automatically formats code using clang-format
- **Format on paste**: Applies formatting to pasted code
- **Format on type**: Real-time formatting as you type

### IntelliSense
- **clang-tidy integration**: Real-time static analysis warnings
- **Include path detection**: Automatic header resolution
- **Symbol navigation**: Fast code navigation and search

### Build Integration
- **CMake integration**: Visual CMake configuration and building
- **Problem matchers**: Parse compiler errors and warnings
- **Task auto-detection**: Automatically discover build tasks

## 🔧 Customization

### Adding Custom Tasks
Create or modify `.vscode/tasks.json` to add custom development tasks:

```json
{
    "label": "Custom Quality Check",
    "type": "shell",
    "command": "./scripts/code-quality.sh",
    "args": ["custom-check"],
    "group": "test",
    "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
    }
}
```

### Configuring Code Quality Tools
Customize the behavior of code quality tools:

- **clang-format**: Edit `.clang-format` in project root
- **clang-tidy**: Modify `.clang-tidy` configuration
- **Doxygen**: Adjust `Doxyfile.in` for documentation preferences

### Adding Extensions
Install additional VS Code extensions by modifying `.devcontainer/devcontainer.json`:

```json
"customizations": {
    "vscode": {
        "extensions": [
            "ms-vscode.cpptools-extension-pack",
            "your-additional-extension"
        ]
    }
}
```

## 🚀 Advanced Features

### Remote Development
- **SSH support**: Connect to remote development machines
- **WSL integration**: Seamless Windows Subsystem for Linux development
- **Container sharing**: Share dev containers across team members

### Performance Optimization
- **Incremental builds**: Fast rebuilds using CMake and Ninja
- **Build caching**: Persistent build artifacts across container restarts
- **Parallel processing**: Multi-core compilation support

### Debugging Features
- **Visual debugging**: Rich debugging experience in VS Code
- **Memory inspection**: Advanced memory debugging with Valgrind
- **Multi-threaded debugging**: Debug complex multi-threaded applications

## 📊 Code Quality Metrics

The dev container provides comprehensive code quality metrics:

### Formatting Compliance
- **Real-time feedback**: Immediate formatting violation highlighting
- **Batch checking**: Verify entire codebase formatting
- **Auto-fixing**: One-click formatting of entire project

### Static Analysis
- **Modern C++ guidelines**: Enforce C++ Core Guidelines
- **Security analysis**: Identify potential security issues
- **Performance suggestions**: Recommendations for optimization

### Documentation Coverage
- **Missing documentation**: Identify undocumented functions/classes
- **Documentation quality**: Verify completeness of Doxygen comments
- **Cross-reference validation**: Ensure all references are valid

## 🛠️ Troubleshooting

### Common Issues

#### Extension Not Working
```bash
# Reload VS Code window
Ctrl+Shift+P → "Developer: Reload Window"

# Check extension status
Ctrl+Shift+P → "Extensions: Show Installed Extensions"
```

#### CMake Configuration Issues
```bash
# Clean and reconfigure
rm -rf build/
cmake --preset default
```

#### Code Quality Tools Not Found
```bash
# Verify tool installation
which clang-format
which clang-tidy
which doxygen

# Reinstall if needed
sudo apt update && sudo apt install clang-format clang-tidy doxygen
```

#### IntelliSense Problems
```bash
# Reset IntelliSense
Ctrl+Shift+P → "C/C++: Reset IntelliSense Database"
```

### Performance Issues
- **Slow builds**: Enable parallel compilation in CMake
- **High memory usage**: Adjust VS Code memory settings
- **Slow IntelliSense**: Configure include paths properly

## 🌐 Integration with External Tools

### CI/CD Integration
Export your dev container configuration for CI/CD pipelines:

```yaml
# GitHub Actions example
jobs:
  quality-check:
    runs-on: ubuntu-latest
    container:
      image: mcr.microsoft.com/vscode/devcontainers/cpp:ubuntu-22.04
    steps:
      - uses: actions/checkout@v3
      - name: Install tools
        run: |
          apt update
          apt install -y clang-format clang-tidy doxygen
      - name: Run quality checks
        run: ./scripts/code-quality.sh check-all
```

### Team Development
- **Consistent environment**: Same development setup for all team members
- **Shared configurations**: Version-controlled tool configurations
- **Reproducible builds**: Identical build environment across machines

The development environment is fully configured and ready to use for professional C++ development with integrated code quality assurance and documentation generation!