#!/bin/bash

set -e

echo "=== Building C++ Docker Application ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if conan is installed
if ! command -v conan &> /dev/null; then
    print_error "Conan is not installed. Please install it first:"
    print_error "pip install conan"
    exit 1
fi

# Create build directory
BUILD_DIR="build"
if [ -d "$BUILD_DIR" ]; then
    print_warning "Build directory exists. Cleaning..."
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
print_status "Created build directory"

# Install dependencies with Conan
print_status "Installing dependencies with Conan..."
conan install . --output-folder="$BUILD_DIR" --build=missing

# Configure with CMake
print_status "Configuring with CMake..."
cd "$BUILD_DIR"
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release

# Build
print_status "Building application..."
cmake --build . --parallel

print_status "Build completed successfully!"
print_status "Executable: ./$BUILD_DIR/cpp-docker-app"