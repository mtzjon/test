# C++ Docker Project with Conan

A modern C++ project template using Docker for containerization and Conan for package management. This project demonstrates best practices for C++ development in a containerized environment with integrated code quality tools and comprehensive documentation.

## 🚀 Features

- **Modern C++17** application structure
- **Conan** for C++ package management
- **Multi-stage Docker** build for optimized images
- **CMake** build system with advanced tooling integration
- **Popular libraries**: fmt for formatting, spdlog for logging
- **Code Quality Tools**: clang-format, clang-tidy integration
- **Documentation**: Doxygen-generated API documentation
- **Development scripts** for easy building and running
- **Docker Compose** for container orchestration
- **Security best practices** (non-root user in container)

## 🛠️ Code Quality & Documentation

This project includes comprehensive code quality and documentation tools:

### Code Formatting
- **clang-format**: Automatic code formatting with Google style (customized)
- **Configuration**: `.clang-format` with C++17 standards
- **Integration**: CMake targets and standalone script

### Static Analysis
- **clang-tidy**: Comprehensive static analysis
- **Configuration**: `.clang-tidy` with modern C++ guidelines
- **Checks**: Includes bugprone, performance, readability, and modernize checks

### Documentation
- **Doxygen**: API documentation generation
- **Style**: Comprehensive Doxygen comments throughout codebase
- **Output**: HTML documentation with search functionality
- **Integration**: CMake targets for easy generation

### Quick Start - Code Quality
```bash
# Install tools (Ubuntu/Debian)
./scripts/code-quality.sh install-deps

# Format all code
./scripts/code-quality.sh format

# Run static analysis
./scripts/code-quality.sh lint

# Generate documentation
./scripts/code-quality.sh docs

# Run all quality checks
./scripts/code-quality.sh check-all
```

## 📁 Project Structure

```
├── src/                    # Source files
│   ├── main.cpp           # Application entry point
│   └── app.cpp            # Main application logic
├── include/               # Header files
│   └── app.h              # Application header
├── scripts/               # Build and utility scripts
│   ├── build.sh           # Local build script
│   ├── code-quality.sh    # Code quality tools script
│   ├── docker-build.sh    # Docker image build script (auto-generated)
│   └── run.sh             # Container run script
├── docker/                # Docker configurations
│   └── README.md          # Docker-specific documentation
├── .devcontainer/         # VS Code dev container setup
│   └── README.md          # Dev container documentation
├── CMakeLists.txt         # CMake configuration
├── conanfile.txt          # Conan dependencies
├── .clang-format          # Code formatting rules
├── .clang-tidy            # Static analysis configuration
├── Doxyfile.in            # Doxygen configuration template
├── Dockerfile             # Multi-stage Docker build
├── docker-compose.yml     # Docker Compose configuration
├── .dockerignore          # Docker build context exclusions
└── README.md              # This file
```

## 🛠️ Prerequisites

### For Local Development
- CMake (3.15+)
- C++ compiler with C++17 support
- Python 3.6+
- Conan package manager (`pip install conan`)

### For Code Quality (Optional but Recommended)
- clang-format (for code formatting)
- clang-tidy (for static analysis)
- doxygen (for documentation generation)
- graphviz (for documentation diagrams)

### For Docker Development
- Docker
- Docker Compose (optional)

## 🏗️ Building and Running

### Local Development

1. **Build the project locally:**
   ```bash
   ./scripts/build.sh
   ```

2. **Run the application:**
   ```bash
   ./build/cpp-docker-app
   ```

### Docker Development

1. **Build the Docker image:**
   ```bash
   ./scripts/docker-build.sh
   ```

2. **Run the container:**
   ```bash
   ./scripts/run.sh
   ```

3. **Or use Docker Compose:**
   ```bash
   # Run production container
   docker-compose up cpp-app

   # Run development container
   docker-compose --profile dev up cpp-app-dev
   ```

### Advanced Usage

#### Build with custom image name and tag:
```bash
./scripts/docker-build.sh --name my-app --tag v1.0.0
```

#### Build development image:
```bash
./scripts/docker-build.sh --dev
```

#### Run with custom container name:
```bash
./scripts/run.sh --name my-container
```

#### Run in interactive mode:
```bash
./scripts/run.sh --interactive
```

#### Build and run in one command:
```bash
./scripts/run.sh --build
```

## 🔧 Development Workflow

### Code Quality Integration

The project includes comprehensive CMake targets for code quality:

```bash
# Using CMake targets (after cmake configure)
make format          # Format code
make format-check    # Check formatting
make tidy            # Run static analysis
make tidy-fix        # Apply automatic fixes
make docs            # Generate documentation
make docs-open       # Generate and open docs
make quality-check   # Run all checks
make format-and-fix  # Format and fix code
```

```bash
# Using the convenience script
./scripts/code-quality.sh format        # Format code
./scripts/code-quality.sh format-check  # Check formatting
./scripts/code-quality.sh lint          # Run static analysis
./scripts/code-quality.sh lint-fix      # Apply automatic fixes
./scripts/code-quality.sh docs          # Generate documentation
./scripts/code-quality.sh docs-open     # Generate and open docs
./scripts/code-quality.sh check-all     # Run all checks
./scripts/code-quality.sh fix-all       # Format and fix code
```

### Adding New Dependencies

1. Edit `conanfile.txt` and add your dependency:
   ```txt
   [requires]
   fmt/10.1.1
   spdlog/1.12.0
   your-package/version
   ```

2. Update `CMakeLists.txt`:
   ```cmake
   find_package(your-package REQUIRED)
   target_link_libraries(${PROJECT_NAME} your-package::your-package)
   ```

3. Rebuild the project

### Documentation Guidelines

This project uses Doxygen for API documentation. Follow these guidelines:

- **File headers**: Include @file, @brief, @author, @date, @version
- **Class documentation**: Use @class, @brief, detailed description
- **Function documentation**: Include @brief, @param, @return, @throws
- **Code examples**: Use @code{.cpp} blocks for usage examples
- **Cross-references**: Use @see for related functions/classes

Example:
```cpp
/**
 * @brief Displays a formatted greeting message
 * 
 * @param name The name to include in the greeting message
 * @return void
 * 
 * @code{.cpp}
 * app.greet("World");  // Outputs: "Hello, World!"
 * @endcode
 */
void greet(const std::string& name);
```

### Project Configuration

- **CMake**: Modify `CMakeLists.txt` for build configuration
- **Conan**: Update `conanfile.txt` for dependencies
- **Docker**: Customize `Dockerfile` for container setup
- **Compose**: Adjust `docker-compose.yml` for orchestration
- **Code Style**: Modify `.clang-format` for formatting preferences
- **Static Analysis**: Adjust `.clang-tidy` for analysis rules
- **Documentation**: Customize `Doxyfile.in` for documentation settings

## 🧪 Testing the Setup

After building, the application will:
1. Initialize logging
2. Greet "Docker World" and "Conan Package Manager"
3. Process 5 demo items with formatted output
4. Display completion message

Expected output:
```
[info] === C++ Docker Application ===
[info] Initializing application...
[info] Starting C++ Docker application
Hello, Docker World!
[info] Hello, Docker World!
Hello, Conan Package Manager!
[info] Hello, Conan Package Manager!
[info] Processing item #1
[info] Processing item #2
[info] Processing item #3
[info] Processing item #4
[info] Processing item #5
[info] Application completed successfully
[info] Cleaning up application...
```

## 📚 Documentation

### API Documentation
Generate comprehensive API documentation:
```bash
./scripts/code-quality.sh docs-open
```

The documentation includes:
- **API Reference**: Complete class and function documentation
- **Usage Examples**: Code snippets and examples
- **Cross-References**: Linked references between related components
- **Source Browser**: Browse source code with syntax highlighting

### Additional Documentation
- **Docker Setup**: See [docker/README.md](docker/README.md)
- **Dev Container**: See [.devcontainer/README.md](.devcontainer/README.md)

## 🔧 Code Quality Tools

### clang-format
- **Style**: Based on Google style with customizations
- **Line Length**: 100 characters
- **Indentation**: 4 spaces
- **Braces**: Attach style
- **Pointer Alignment**: Left

### clang-tidy
- **Checks**: Comprehensive set including:
  - `bugprone-*`: Bug-prone code patterns
  - `cert-*`: CERT security guidelines
  - `cppcoreguidelines-*`: C++ Core Guidelines
  - `modernize-*`: Modern C++ features
  - `performance-*`: Performance improvements
  - `readability-*`: Code readability

### Doxygen
- **Output**: HTML with search functionality
- **Features**: 
  - Source browser
  - Class diagrams (with Graphviz)
  - Cross-referenced documentation
  - Example code highlighting

## 🐳 Docker Details

### Multi-stage Build
- **Builder stage**: Contains all build dependencies and tools
- **Runtime stage**: Minimal image with only the compiled application

### Security Features
- Non-root user execution
- Minimal runtime dependencies
- Clean layer separation

### Image Sizes
- Builder image: ~800MB (includes all build tools)
- Runtime image: ~100MB (optimized for production)

## 📝 Scripts Documentation

### `scripts/build.sh`
Local development build script with dependency management and colored output.

### `scripts/code-quality.sh`
Comprehensive code quality tool with commands for:
- Code formatting and format checking
- Static analysis with automatic fixes
- Documentation generation
- Dependency installation
- All-in-one quality checks

### `scripts/docker-build.sh`
Docker image builder with options for:
- Custom image names and tags
- Development vs production builds
- Help documentation

### `scripts/run.sh`
Container runner with features:
- Image existence checking
- Container cleanup
- Interactive mode
- Build-then-run option

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes following the coding standards:
   ```bash
   ./scripts/code-quality.sh format      # Format your code
   ./scripts/code-quality.sh lint-fix   # Apply automatic fixes
   ./scripts/code-quality.sh check-all  # Run all quality checks
   ```
4. Add appropriate Doxygen documentation
5. Test with both local and Docker builds
6. Submit a pull request

### Pre-commit Checklist
- [ ] Code is formatted with clang-format
- [ ] Static analysis passes with clang-tidy
- [ ] All functions and classes have Doxygen documentation
- [ ] Documentation builds without warnings
- [ ] Tests pass in both local and Docker environments

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Useful Resources

- [Conan Documentation](https://docs.conan.io/)
- [CMake Documentation](https://cmake.org/documentation/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [fmt Library](https://fmt.dev/)
- [spdlog Library](https://github.com/gabime/spdlog)
- [clang-format Documentation](https://clang.llvm.org/docs/ClangFormat.html)
- [clang-tidy Documentation](https://clang.llvm.org/extra/clang-tidy/)
- [Doxygen Documentation](https://www.doxygen.nl/manual/)
- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)