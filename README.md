# C++ Docker Project with Conan

A modern C++ project template using Docker for containerization and Conan for package management. This project demonstrates best practices for C++ development in a containerized environment.

## 🚀 Features

- **Modern C++17** application structure
- **Conan** for C++ package management
- **Multi-stage Docker** build for optimized images
- **CMake** build system
- **Popular libraries**: fmt for formatting, spdlog for logging
- **Development scripts** for easy building and running
- **Docker Compose** for container orchestration
- **Security best practices** (non-root user in container)

## 📁 Project Structure

```
├── src/                    # Source files
│   ├── main.cpp           # Application entry point
│   └── app.cpp            # Main application logic
├── include/               # Header files
│   └── app.h              # Application header
├── scripts/               # Build and utility scripts
│   ├── build.sh           # Local build script
│   ├── docker-build.sh    # Docker image build script
│   └── run.sh             # Container run script
├── CMakeLists.txt         # CMake configuration
├── conanfile.txt          # Conan dependencies
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

## 🔧 Development

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

### Project Configuration

- **CMake**: Modify `CMakeLists.txt` for build configuration
- **Conan**: Update `conanfile.txt` for dependencies
- **Docker**: Customize `Dockerfile` for container setup
- **Compose**: Adjust `docker-compose.yml` for orchestration

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
3. Make your changes
4. Test with both local and Docker builds
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Useful Resources

- [Conan Documentation](https://docs.conan.io/)
- [CMake Documentation](https://cmake.org/documentation/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [fmt Library](https://fmt.dev/)
- [spdlog Library](https://github.com/gabime/spdlog)