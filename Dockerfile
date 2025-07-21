# Multi-stage build for C++ application with Conan
FROM ubuntu:22.04 AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Conan
RUN pip3 install conan

# Set up Conan profile
RUN conan profile detect --force

# Set working directory
WORKDIR /app

# Copy Conan files first (for better caching)
COPY conanfile.txt .

# Install dependencies
RUN conan install . --output-folder=build --build=missing

# Copy source code
COPY CMakeLists.txt .
COPY include/ include/
COPY src/ src/

# Configure and build
WORKDIR /app/build
RUN cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
RUN cmake --build . --parallel

# Runtime stage
FROM ubuntu:22.04 AS runtime

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash appuser

# Copy built application
COPY --from=builder /app/build/cpp-docker-app /usr/local/bin/

# Set ownership
RUN chown appuser:appuser /usr/local/bin/cpp-docker-app

# Switch to non-root user
USER appuser

# Set entry point
ENTRYPOINT ["/usr/local/bin/cpp-docker-app"]