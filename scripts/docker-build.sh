#!/bin/bash

set -e

echo "=== Building Docker Image ==="

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

# Default values
IMAGE_NAME="cpp-docker-app"
IMAGE_TAG="latest"
BUILD_TARGET="runtime"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            IMAGE_NAME="$2"
            shift 2
            ;;
        -t|--tag)
            IMAGE_TAG="$2"
            shift 2
            ;;
        --dev)
            BUILD_TARGET="builder"
            IMAGE_TAG="dev"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -n, --name NAME    Set image name (default: cpp-docker-app)"
            echo "  -t, --tag TAG      Set image tag (default: latest)"
            echo "  --dev              Build development image"
            echo "  -h, --help         Show this help message"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

print_status "Building Docker image: $FULL_IMAGE_NAME"
print_status "Target stage: $BUILD_TARGET"

# Build the Docker image
docker build \
    --target "$BUILD_TARGET" \
    -t "$FULL_IMAGE_NAME" \
    .

print_status "Docker image built successfully: $FULL_IMAGE_NAME"

# Show image info
print_status "Image information:"
docker images "$IMAGE_NAME" --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"