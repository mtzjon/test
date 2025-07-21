# Docker Setup for C++ Application

This directory contains Docker configuration files for building and running the C++ application in various environments.

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
- `development` - Debug build with development tools
- `builder` - Production build stage
- `production` - Minimal runtime image

## Environment Variables

- `APP_ENV` - Application environment (production, development, test, staging)
- `LOG_LEVEL` - Logging level (debug, info, warn, error)
- `CMAKE_BUILD_TYPE` - CMake build type (Debug, Release)

## Docker Commands

### Build specific target
```bash
docker build -f docker/Dockerfile --target production -t cpp-app:prod .
```

### Build with custom build args
```bash
docker build -f docker/Dockerfile --build-arg CMAKE_BUILD_TYPE=Release .
```

### Run with custom environment
```bash
docker run -e APP_ENV=production -e LOG_LEVEL=info cpp-app:latest
```

## Volume Mounts

The development service mounts the source code for live development:
- Host `..` → Container `/app`
- Named volume `build-cache` → Container `/app/build`

## Networking

Default network configuration uses bridge networking with subnet `172.20.0.0/16`.

## Security Features

Production containers run with:
- Non-root user (`appuser`)
- Read-only filesystem
- Dropped capabilities
- Resource limits
- Health checks

## Debugging

For development, GDB remote debugging is available on port 2345.

## Logs

Production logs are configured with JSON format and rotation (max 10MB, 3 files).

## Cleanup

Remove all containers and images:

```bash
docker-compose down --rmi all --volumes --remove-orphans
```