#!/bin/bash

set -e

echo "=== Running C++ Docker Application ==="

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
IMAGE_NAME="cpp-docker-app:latest"
CONTAINER_NAME="cpp-docker-app-instance"
RUN_MODE="run"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--image)
            IMAGE_NAME="$2"
            shift 2
            ;;
        -n|--name)
            CONTAINER_NAME="$2"
            shift 2
            ;;
        --interactive)
            RUN_MODE="interactive"
            shift
            ;;
        --build)
            print_status "Building image first..."
            ./scripts/docker-build.sh
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -i, --image IMAGE     Docker image to run (default: cpp-docker-app:latest)"
            echo "  -n, --name NAME       Container name (default: cpp-docker-app-instance)"
            echo "  --interactive         Run in interactive mode"
            echo "  --build               Build image before running"
            echo "  -h, --help            Show this help message"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if image exists
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    print_error "Docker image '$IMAGE_NAME' not found"
    print_status "Build the image first with: ./scripts/docker-build.sh"
    exit 1
fi

# Remove existing container if it exists
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    print_warning "Removing existing container: $CONTAINER_NAME"
    docker rm -f "$CONTAINER_NAME" >/dev/null
fi

print_status "Running container: $CONTAINER_NAME"
print_status "Using image: $IMAGE_NAME"

if [ "$RUN_MODE" = "interactive" ]; then
    print_status "Running in interactive mode..."
    docker run -it --name "$CONTAINER_NAME" "$IMAGE_NAME" /bin/bash
else
    print_status "Running application..."
    docker run --name "$CONTAINER_NAME" "$IMAGE_NAME"
fi

print_status "Container finished."