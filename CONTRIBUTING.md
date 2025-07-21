# Contributing to C++ Docker Project

Thank you for your interest in contributing to this project! This guide will help you get started with contributing code, documentation, and other improvements.

## 🚀 Quick Start

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/cpp-docker-project.git
   cd cpp-docker-project
   ```
3. **Install dependencies** (if developing locally):
   ```bash
   ./scripts/code-quality.sh install-deps
   ```
4. **Set up development environment** (choose one):
   - **VS Code Dev Container**: Open in VS Code and select "Reopen in Container"
   - **Local development**: Install CMake, Conan, and C++ compiler
   - **Docker development**: Use the provided Docker setup

## 📋 Development Workflow

### 1. Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-description
```

### 2. Make Your Changes
- Write code following our [coding standards](#coding-standards)
- Add appropriate [documentation](#documentation-requirements)
- Include [tests](#testing) where applicable

### 3. Quality Checks
Before committing, run all quality checks:

```bash
# Format your code
./scripts/code-quality.sh format

# Run static analysis and apply fixes
./scripts/code-quality.sh lint-fix

# Run all quality checks
./scripts/code-quality.sh check-all

# Generate documentation to verify it builds
./scripts/code-quality.sh docs
```

### 4. Commit Your Changes
```bash
git add .
git commit -m "feat: add new feature X"
# or
git commit -m "fix: resolve issue with Y"
```

Use [conventional commits](https://www.conventionalcommits.org/) format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

### 5. Push and Create Pull Request
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear description of changes
- Reference to any related issues
- Screenshots for UI changes (if applicable)

## 🛠️ Coding Standards

### Code Formatting
- Use **clang-format** with the provided `.clang-format` configuration
- **Line length**: Maximum 100 characters
- **Indentation**: 4 spaces, no tabs
- **Braces**: Attach style (`{` on same line)
- **Pointer alignment**: Left (`int* ptr`, not `int *ptr`)

### C++ Guidelines
- Follow **C++ Core Guidelines**
- Use **modern C++17** features
- Prefer **RAII** for resource management
- Use **smart pointers** instead of raw pointers
- Prefer **const** wherever possible
- Use **meaningful variable names**

### Static Analysis
- Code must pass **clang-tidy** checks
- Fix all warnings when possible
- Use `// NOLINT` sparingly and with justification
- Avoid **magic numbers** (use named constants)

### Example Code Style
```cpp
/**
 * @brief Example function demonstrating coding style
 * 
 * @param inputData The data to process
 * @param options Processing options
 * @return ProcessingResult The result of processing
 */
ProcessingResult processData(const InputData& inputData, 
                           const ProcessingOptions& options) {
    // Use meaningful variable names
    const auto processedItems = inputData.getItems();
    
    // Prefer range-based for loops
    for (const auto& item : processedItems) {
        if (!item.isValid()) {
            continue;
        }
        
        // Process item...
    }
    
    return ProcessingResult{/* ... */};
}
```

## 📚 Documentation Requirements

### Code Documentation
All public APIs must have **Doxygen documentation**:

```cpp
/**
 * @file filename.h
 * @brief Brief description of the file
 * @author Your Name
 * @date 2024
 */

/**
 * @class MyClass
 * @brief Brief description of the class
 * 
 * Detailed description of what the class does,
 * how to use it, and any important notes.
 * 
 * @code{.cpp}
 * MyClass obj;
 * obj.doSomething();
 * @endcode
 */
class MyClass {
public:
    /**
     * @brief Brief description of the method
     * 
     * @param param1 Description of parameter 1
     * @param param2 Description of parameter 2
     * @return Description of return value
     * @throws std::exception When this might be thrown
     * 
     * @pre Preconditions for calling this method
     * @post Postconditions after method execution
     */
    ReturnType methodName(const Type& param1, int param2);
};
```

### Required Documentation Elements
- **File headers**: `@file`, `@brief`, `@author`, `@date`
- **Class documentation**: `@class`, `@brief`, detailed description
- **Function documentation**: `@brief`, `@param`, `@return`, `@throws`
- **Usage examples**: `@code` blocks where helpful
- **Cross-references**: `@see` for related functions

### Documentation Quality
- Verify documentation builds without warnings:
  ```bash
  ./scripts/code-quality.sh docs
  ```
- Check generated documentation for completeness
- Include usage examples for complex APIs
- Document any non-obvious behavior

## 🧪 Testing

### Current Testing
- Application builds successfully
- All quality checks pass
- Documentation generates without errors

### Future Testing (when implemented)
- Unit tests for all new functionality
- Integration tests for major features
- Performance tests for critical paths

### Running Tests
```bash
# Build and test locally
./scripts/build.sh
./build/cpp-docker-app

# Test in Docker
./scripts/docker-build.sh
./scripts/run.sh

# Quality checks
./scripts/code-quality.sh check-all
```

## 🔍 Code Review Process

### Before Submitting
- [ ] Code follows formatting standards (clang-format)
- [ ] Static analysis passes (clang-tidy)
- [ ] All functions/classes have Doxygen documentation
- [ ] Documentation builds without warnings
- [ ] Application builds and runs correctly
- [ ] No unnecessary files included in commit

### Review Checklist
Reviewers will check:
- **Code quality**: Following C++ best practices
- **Documentation**: Complete and accurate API docs
- **Testing**: Adequate test coverage
- **Security**: No security vulnerabilities
- **Performance**: No obvious performance issues
- **Maintainability**: Code is readable and well-structured

## 🚀 Development Environment Setup

### Option 1: VS Code Dev Container (Recommended)
1. Install VS Code and Dev Containers extension
2. Open project in VS Code
3. Click "Reopen in Container" when prompted
4. Everything is automatically configured!

### Option 2: Local Development
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y cmake ninja-build gcc g++ python3 python3-pip
pip3 install conan
./scripts/code-quality.sh install-deps

# Build
./scripts/build.sh
```

### Option 3: Docker Development
```bash
# Build development image
docker build -f Dockerfile --target development -t cpp-app:dev .

# Run development container
docker run -it -v $(pwd):/app cpp-app:dev bash
```

## 🐛 Reporting Issues

### Bug Reports
Include:
- **Environment**: OS, compiler version, build type
- **Steps to reproduce**: Clear, numbered steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Logs/Output**: Relevant error messages or output

### Feature Requests
Include:
- **Use case**: Why is this feature needed?
- **Proposed solution**: How should it work?
- **Alternatives**: Other solutions considered
- **Breaking changes**: Any compatibility concerns

## 🏗️ Build System

### CMake Targets
```bash
# Configure
cmake --preset default

# Build
cmake --build build

# Available targets
make -C build help
```

### Code Quality Targets
```bash
make format          # Format code
make format-check    # Check formatting
make tidy            # Run static analysis
make tidy-fix        # Apply automatic fixes
make docs            # Generate documentation
make quality-check   # Run all checks
```

## 📦 Dependencies

### Required Dependencies
- **CMake** 3.15+
- **C++17** compatible compiler
- **Conan** package manager
- **Python** 3.6+ (for Conan)

### Code Quality Dependencies
- **clang-format** (code formatting)
- **clang-tidy** (static analysis)
- **doxygen** (documentation)
- **graphviz** (documentation diagrams)

### External Libraries
- **fmt**: String formatting
- **spdlog**: Logging

## 📋 Release Process

### Version Numbering
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist
- [ ] All tests pass
- [ ] Documentation is up to date
- [ ] CHANGELOG is updated
- [ ] Version numbers are updated
- [ ] Docker images build successfully
- [ ] Release notes are prepared

## 🤝 Community Guidelines

### Code of Conduct
- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain professionalism

### Communication
- **Issues**: For bug reports and feature requests
- **Discussions**: For questions and general discussion
- **Pull Requests**: For code contributions
- **Wiki**: For extended documentation

### Getting Help
- Check existing issues and documentation first
- Provide clear, detailed questions
- Include relevant code snippets or logs
- Be patient and respectful

## 🏆 Recognition

Contributors will be:
- Listed in the project's contributors
- Credited in release notes for significant contributions
- Mentioned in documentation for major features

Thank you for contributing to making this project better! 🎉