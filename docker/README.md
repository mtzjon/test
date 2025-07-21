# Docker Setup for C++ Application

This directory contains Docker configuration files for building and running the C++ application in various environments with integrated code quality tools and documentation generation.

## Files

- `Dockerfile` - Multi-stage Docker build configuration
- `docker-compose.yml` - Docker Compose configuration with multiple service profiles
- `.dockerignore` - Files and directories to exclude from Docker context

## Quick Start

### Production

Build and run the application in production mode:

```bash
cd docker
docker-compose up --build cpp-app
```

### Development

Run the application in development mode with source code mounting:

```bash
cd docker
docker-compose --profile dev up --build cpp-app-dev
```

Then access the container for development:

```bash
docker exec -it cpp-docker-app-dev bash
```

### Testing

Run tests in a containerized environment:

```bash
cd docker
docker-compose --profile test up --build cpp-app-test
```

### Staging

Run the application in a production-like staging environment:

```bash
cd docker
docker-compose --profile staging up --build cpp-app-staging
```

## Build Targets

The Dockerfile includes multiple build targets:

- `base` - Base image with build tools and Conan
- `development` - Debug build with development tools and code quality tools
- `builder` - Production build stage
- `production` - Minimal runtime image

## Code Quality in Docker

### Development Image Features

The development Docker image includes:

- **clang-format**: Code formatting tool
- **clang-tidy**: Static analysis tool
- **doxygen**: Documentation generation
- **graphviz**: For generating documentation diagrams
- **All build tools**: cmake, gcc, ninja

### Running Code Quality Tools in Container

```bash
# Start development container
docker-compose --profile dev up -d cpp-app-dev

# Format code
docker exec cpp-docker-app-dev ./scripts/code-quality.sh format

# Run static analysis
docker exec cpp-docker-app-dev ./scripts/code-quality.sh lint

# Generate documentation
docker exec cpp-docker-app-dev ./scripts/code-quality.sh docs

# Run all quality checks
docker exec cpp-docker-app-dev ./scripts/code-quality.sh check-all
```

### Documentation Generation

Generate documentation in the containerized environment:

```bash
# Generate documentation
docker exec cpp-docker-app-dev make docs

# Copy documentation to host
docker cp cpp-docker-app-dev:/app/build/docs/html ./docs
```

## Environment Variables

- `APP_ENV` - Application environment (production, development, test, staging)
- `LOG_LEVEL` - Logging level (debug, info, warn, error)
- `CMAKE_BUILD_TYPE` - CMake build type (Debug, Release)
- `ENABLE_CODE_QUALITY` - Enable code quality tools (true/false, dev only)

## Docker Commands

### Build specific target
```bash
docker build -f docker/Dockerfile --target production -t cpp-app:prod .
```

### Build development image with code quality tools
```bash
docker build -f docker/Dockerfile --target development -t cpp-app:dev .
```

### Build with custom build args
```bash
docker build -f docker/Dockerfile \
  --build-arg CMAKE_BUILD_TYPE=Release \
  --build-arg ENABLE_CODE_QUALITY=true \
  .
```

### Run with custom environment
```bash
docker run -e APP_ENV=production -e LOG_LEVEL=info cpp-app:latest
```

### Development with code quality
```bash
docker run -it \
  -v $(pwd):/app \
  -e ENABLE_CODE_QUALITY=true \
  cpp-app:dev bash
```

## Volume Mounts

The development service mounts the source code for live development:
- Host `..` → Container `/app` (source code)
- Named volume `build-cache` → Container `/app/build` (build artifacts)
- Named volume `docs-cache` → Container `/app/docs` (generated documentation)

## Networking

Default network configuration uses bridge networking with subnet `172.20.0.0/16`.

## Security Features

Production containers run with:
- Non-root user (`appuser`)
- Read-only filesystem
- Dropped capabilities
- Resource limits
- Health checks

Development containers include additional tools but maintain security:
- Non-root user for development
- Isolated environment
- Controlled tool access

## Debugging

For development, GDB remote debugging is available on port 2345.

### Code Quality Debugging

Debug code quality issues in the container:

```bash
# Check clang-format configuration
docker exec cpp-docker-app-dev clang-format --version

# Check clang-tidy configuration
docker exec cpp-docker-app-dev clang-tidy --version

# Verify doxygen installation
docker exec cpp-docker-app-dev doxygen --version

# Run quality checks with verbose output
docker exec cpp-docker-app-dev ./scripts/code-quality.sh check-all
```

## Logs

Production logs are configured with JSON format and rotation (max 10MB, 3 files).

Development logs include code quality tool output and are more verbose.

## Multi-stage Build Details

### Base Stage
- Ubuntu 22.04 LTS
- Essential build tools
- Conan package manager
- CMake and build essentials

### Development Stage
Extends base with:
- Code quality tools (clang-format, clang-tidy, doxygen)
- Additional development utilities
- Documentation generation tools
- Debugging tools

### Builder Stage
- Optimized build environment
- Dependency installation and compilation
- Application compilation
- Strip debugging symbols for production

### Production Stage
- Minimal runtime image
- Only compiled application
- Security-hardened
- Non-root user execution

## CI/CD Integration

### Code Quality in CI

The Docker setup supports CI/CD pipelines with code quality checks:

```yaml
# Example CI configuration
version: '3.8'
services:
  ci-quality-check:
    build:
      context: .
      dockerfile: Dockerfile
      target: development
    volumes:
      - .:/app
    command: |
      bash -c "
        ./scripts/code-quality.sh format-check &&
        ./scripts/code-quality.sh lint &&
        ./scripts/code-quality.sh docs
      "
```

### Documentation Deployment

Generate and deploy documentation:

```bash
# Build documentation in container
docker-compose --profile dev run --rm cpp-app-dev ./scripts/code-quality.sh docs

# Extract documentation
docker cp $(docker-compose ps -q cpp-app-dev):/app/build/docs/html ./documentation

# Deploy to web server or documentation hosting
```

## Performance Considerations

### Build Optimization
- Multi-stage builds minimize final image size
- Build cache optimization for faster rebuilds
- Parallel builds when possible

### Development Workflow
- Source code mounted for live editing
- Build artifacts cached in named volumes
- Incremental builds supported

### Documentation Generation
- Documentation built in separate volume
- Cached between container restarts
- Can be extracted for deployment

## Cleanup

Remove all containers and images:

```bash
docker-compose down --rmi all --volumes --remove-orphans
```

Remove only development containers:

```bash
docker-compose --profile dev down --volumes
```

Clean up documentation volumes:

```bash
docker volume rm $(docker volume ls -q | grep docs)
```

## Troubleshooting

### Common Issues

#### Code Quality Tools Not Found
```bash
# Verify tools are installed in development image
docker exec cpp-docker-app-dev which clang-format
docker exec cpp-docker-app-dev which clang-tidy
docker exec cpp-docker-app-dev which doxygen
```

#### Documentation Generation Fails
```bash
# Check doxygen configuration
docker exec cpp-docker-app-dev doxygen -g test-config
docker exec cpp-docker-app-dev ./scripts/code-quality.sh docs 2>&1 | tee doc-build.log
```

#### Permission Issues
```bash
# Fix ownership of generated files
docker exec cpp-docker-app-dev chown -R $(id -u):$(id -g) /app/build
```

#### Build Cache Issues
```bash
# Clear build cache
docker volume rm cpp-docker-project_build-cache

# Rebuild without cache
docker-compose build --no-cache cpp-app-dev
```

### Resource Requirements

- **Production Image**: ~100MB, minimal CPU/memory
- **Development Image**: ~800MB, requires more resources for tools
- **Documentation Build**: Additional ~50MB for generated docs
- **Recommended**: 2GB RAM, 2 CPU cores for comfortable development