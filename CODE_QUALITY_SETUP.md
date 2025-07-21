# Code Quality Setup - Quick Reference

This document provides a quick reference for the code quality tools and documentation setup added to the C++ Docker Project.

## 📁 Files Added/Modified

### Configuration Files
- `.clang-format` - Code formatting configuration
- `.clang-tidy` - Static analysis configuration
- `Doxyfile.in` - Doxygen documentation template

### Scripts
- `scripts/code-quality.sh` - Comprehensive code quality automation script

### Documentation
- `README.md` - Updated with code quality and documentation information
- `docker/README.md` - Updated with Docker code quality integration
- `.devcontainer/README.md` - Updated with VS Code dev container features
- `CONTRIBUTING.md` - New comprehensive contributing guide
- `CODE_QUALITY_SETUP.md` - This quick reference guide

### Build System
- `CMakeLists.txt` - Enhanced with code quality targets and Doxygen integration

### CI/CD
- `.github/workflows/code-quality.yml` - GitHub Actions workflow for automated quality checks

### Source Code
- Enhanced all source files (`src/*.cpp`, `include/*.h`) with comprehensive Doxygen documentation

## 🛠️ Tools Integrated

### Code Formatting
- **Tool**: clang-format
- **Standard**: Google style (customized)
- **Line Length**: 100 characters
- **Usage**: `./scripts/code-quality.sh format`

### Static Analysis
- **Tool**: clang-tidy
- **Checks**: bugprone, cert, cppcoreguidelines, modernize, performance, readability
- **Usage**: `./scripts/code-quality.sh lint`

### Documentation
- **Tool**: Doxygen
- **Output**: HTML with search functionality
- **Usage**: `./scripts/code-quality.sh docs`

## 🚀 Quick Commands

### Basic Operations
```bash
# Install dependencies (Ubuntu/Debian)
./scripts/code-quality.sh install-deps

# Format all code
./scripts/code-quality.sh format

# Check formatting
./scripts/code-quality.sh format-check

# Run static analysis
./scripts/code-quality.sh lint

# Apply automatic fixes
./scripts/code-quality.sh lint-fix

# Generate documentation
./scripts/code-quality.sh docs

# Generate and open documentation
./scripts/code-quality.sh docs-open
```

### Comprehensive Operations
```bash
# Run all quality checks
./scripts/code-quality.sh check-all

# Apply all automatic fixes
./scripts/code-quality.sh fix-all
```

### CMake Targets
```bash
# After cmake configuration
make format          # Format code
make format-check    # Check formatting
make tidy            # Run static analysis
make tidy-fix        # Apply automatic fixes
make docs            # Generate documentation
make docs-open       # Generate and open docs
make quality-check   # Run all checks
make format-and-fix  # Format and fix code
```

## 📋 Development Workflow

### Before Committing
1. **Format code**: `./scripts/code-quality.sh format`
2. **Fix static analysis issues**: `./scripts/code-quality.sh lint-fix`
3. **Run all checks**: `./scripts/code-quality.sh check-all`
4. **Verify documentation**: `./scripts/code-quality.sh docs`

### One-Command Setup
```bash
# Format, fix, and check everything
./scripts/code-quality.sh fix-all && ./scripts/code-quality.sh check-all
```

## 🔧 Configuration Details

### clang-format (.clang-format)
- **Base Style**: Google
- **Indentation**: 4 spaces
- **Column Limit**: 100
- **Brace Style**: Attach
- **Pointer Alignment**: Left

### clang-tidy (.clang-tidy)
- **Enabled Checks**: Comprehensive set for modern C++
- **Naming Conventions**: CamelCase for classes, camelCase for functions
- **Header Filter**: `(src|include)/.*\.h(pp)?$`

### Doxygen (Doxyfile.in)
- **Output Format**: HTML
- **Source Browser**: Enabled
- **Search Engine**: Enabled
- **Graphs**: Class diagrams (requires Graphviz)

## 🐳 Docker Integration

### Development Container
```bash
# Build development image
docker build --target development -t cpp-app:dev .

# Run with code quality tools
docker run -it -v $(pwd):/app cpp-app:dev bash
./scripts/code-quality.sh check-all
```

### Using Docker Compose
```bash
# Start development environment
docker-compose --profile dev up -d

# Run code quality checks in container
docker exec cpp-docker-app-dev ./scripts/code-quality.sh check-all
```

## 🔄 VS Code Integration

### Dev Container Features
- Pre-installed code quality tools
- Configured VS Code tasks
- Real-time formatting and linting
- Integrated documentation generation

### Available Tasks
- **Format Code**: Ctrl+Shift+P → "Tasks: Run Task" → "Format Code"
- **Run Linter**: Ctrl+Shift+P → "Tasks: Run Task" → "Run Linter"
- **Generate Docs**: Ctrl+Shift+P → "Tasks: Run Task" → "Generate Documentation"

## 🚦 CI/CD Integration

### GitHub Actions Workflow
- **Triggers**: Push to main/develop, Pull Requests
- **Checks**: Format, lint, build, documentation
- **Artifacts**: Generated documentation
- **Security**: Trivy vulnerability scanning
- **Deployment**: Automatic documentation deployment to GitHub Pages

### Workflow Jobs
1. **code-quality**: Format check, static analysis, build, documentation
2. **docker-quality**: Docker build and quality checks
3. **security-scan**: Vulnerability scanning (PR only)
4. **documentation-deploy**: Deploy docs to GitHub Pages (main branch)

## 📊 Quality Metrics

### Formatting Compliance
- All source files follow clang-format rules
- Automatic formatting on save (VS Code)
- CI checks prevent non-compliant code

### Static Analysis
- Zero clang-tidy warnings in default configuration
- Modern C++ guidelines enforcement
- Automatic fixes for common issues

### Documentation Coverage
- All public APIs documented with Doxygen
- Usage examples for complex functions
- Cross-referenced documentation

## 🎯 Best Practices

### Code Documentation
```cpp
/**
 * @brief Brief description of function
 * 
 * Detailed description explaining the purpose,
 * behavior, and any important notes.
 * 
 * @param param1 Description of parameter
 * @return Description of return value
 * @throws std::exception When this might throw
 * 
 * @code{.cpp}
 * // Usage example
 * auto result = myFunction(value);
 * @endcode
 */
```

### Commit Message Format
```bash
git commit -m "feat: add new feature"
git commit -m "fix: resolve specific issue"
git commit -m "docs: update documentation"
git commit -m "style: format code"
git commit -m "refactor: improve code structure"
```

### Pre-commit Checklist
- [ ] Code is formatted with clang-format
- [ ] Static analysis passes
- [ ] All functions documented
- [ ] Documentation builds cleanly
- [ ] Application builds and runs
- [ ] Tests pass (when implemented)

## 🆘 Troubleshooting

### Common Issues

#### Tool Not Found
```bash
# Check if tools are installed
which clang-format clang-tidy doxygen

# Install missing tools
./scripts/code-quality.sh install-deps
```

#### Format Check Fails
```bash
# See what needs formatting
./scripts/code-quality.sh format-check

# Apply formatting
./scripts/code-quality.sh format
```

#### Static Analysis Fails
```bash
# See specific issues
./scripts/code-quality.sh lint

# Apply automatic fixes
./scripts/code-quality.sh lint-fix
```

#### Documentation Build Fails
```bash
# Check Doxygen configuration
doxygen -g test-config

# Run with verbose output
./scripts/code-quality.sh docs 2>&1 | tee doc-build.log
```

### Getting Help
- Check the main README.md for detailed information
- Review CONTRIBUTING.md for development guidelines
- Look at individual tool documentation
- Check GitHub Issues for known problems

## 🎉 Success Indicators

Your setup is working correctly when:
- `./scripts/code-quality.sh check-all` passes without errors
- Documentation generates without warnings
- CI/CD pipeline passes all checks
- VS Code shows real-time formatting and linting feedback
- All source files follow consistent formatting

## 📚 Additional Resources

- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/)
- [clang-format Documentation](https://clang.llvm.org/docs/ClangFormat.html)
- [clang-tidy Documentation](https://clang.llvm.org/extra/clang-tidy/)
- [Doxygen Documentation](https://www.doxygen.nl/manual/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

*This setup provides a comprehensive code quality foundation for modern C++ development with automatic formatting, static analysis, and documentation generation.*