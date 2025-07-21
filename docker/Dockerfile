# Multi-stage build for C++ application with Conan
# Base image with common tools
FROM ubuntu:22.04 AS base

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Conan
RUN pip3 install --no-cache-dir conan

# Set up Conan profile for better reproducibility
RUN conan profile detect --force

# Development stage
FROM base AS development

# Set working directory
WORKDIR /app

# Copy dependency files first (for better Docker layer caching)
COPY conanfile.txt ./

# Install dependencies with explicit settings for reproducibility
RUN conan install . \
    --output-folder=build \
    --build=missing \
    --settings=build_type=Debug

# Copy source code
COPY CMakeLists.txt ./
COPY include/ ./include/
COPY src/ ./src/

# Configure build for development
WORKDIR /app/build
RUN cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Build the application
RUN cmake --build . --parallel $(nproc)

# Production builder stage
FROM base AS builder

# Set working directory
WORKDIR /app

# Copy dependency files first (for better Docker layer caching)
COPY conanfile.txt ./

# Install dependencies for production build
RUN conan install . \
    --output-folder=build \
    --build=missing \
    --settings=build_type=Release

# Copy source code
COPY CMakeLists.txt ./
COPY include/ ./include/
COPY src/ ./src/

# Configure and build for production
WORKDIR /app/build
RUN cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-O3 -DNDEBUG"

RUN cmake --build . --parallel $(nproc)

# Strip debug symbols for smaller binary
RUN strip cpp-docker-app

# Production runtime stage
FROM ubuntu:22.04 AS production

# Install only runtime dependencies
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Create non-root user for security
RUN groupadd -r appgroup && \
    useradd -r -g appgroup -s /bin/bash -m appuser

# Create application directory
RUN mkdir -p /app && chown appuser:appgroup /app

# Copy built application from builder stage
COPY --from=builder --chown=appuser:appgroup /app/build/cpp-docker-app /app/

# Switch to non-root user
USER appuser

# Set working directory
WORKDIR /app

# Health check (adjust as needed for your application)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ./cpp-docker-app --version || exit 1

# Set entry point
ENTRYPOINT ["./cpp-docker-app"]

# Default command (can be overridden)
CMD []