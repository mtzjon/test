#!/bin/bash

# Docker Helper Script for C++ Application
# Usage: ./docker-helper.sh [command] [options]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$SCRIPT_DIR/docker-compose.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_help() {
    cat << EOF
Docker Helper Script for C++ Application

Usage: $0 [command] [options]

Commands:
    build [target]          Build Docker image (targets: production, development, all)
    run [env]              Run application (env: prod, dev, staging, test)
    shell [env]            Open shell in container (env: dev, prod, staging)
    logs [service]         Show logs for service
    clean                  Clean up containers, images, and volumes
    test                   Run tests in container
    dev                    Start development environment
    stop                   Stop all running containers
    restart [service]      Restart specific service
    status                 Show status of all services
    help                   Show this help message

Examples:
    $0 build production    # Build production image
    $0 run dev            # Run in development mode
    $0 shell dev          # Open shell in development container
    $0 test               # Run tests
    $0 clean              # Clean up everything

Environment Variables:
    DOCKER_BUILDKIT=1     Enable BuildKit (recommended)
    COMPOSE_PARALLEL_LIMIT=4  Limit parallel builds

EOF
}

build_image() {
    local target=${1:-"all"}
    
    log_info "Building Docker image with target: $target"
    
    cd "$SCRIPT_DIR"
    
    case $target in
        "production"|"prod")
            docker compose build cpp-app
            ;;
        "development"|"dev")
            docker compose build cpp-app-dev
            ;;
        "all")
            docker compose build
            ;;
        *)
            log_error "Unknown build target: $target"
            log_info "Available targets: production, development, all"
            exit 1
            ;;
    esac
    
    log_success "Build completed successfully"
}

run_app() {
    local env=${1:-"prod"}
    
    cd "$SCRIPT_DIR"
    
    case $env in
        "prod"|"production")
            log_info "Starting production environment"
            docker compose up cpp-app
            ;;
        "dev"|"development")
            log_info "Starting development environment"
            docker compose --profile dev up cpp-app-dev
            ;;
        "staging")
            log_info "Starting staging environment"
            docker compose --profile staging up cpp-app-staging
            ;;
        "test")
            log_info "Running tests"
            docker compose --profile test up cpp-app-test
            ;;
        *)
            log_error "Unknown environment: $env"
            log_info "Available environments: prod, dev, staging, test"
            exit 1
            ;;
    esac
}

open_shell() {
    local env=${1:-"dev"}
    local container_name
    
    case $env in
        "dev"|"development")
            container_name="cpp-docker-app-dev"
            ;;
        "prod"|"production")
            container_name="cpp-docker-app-prod"
            ;;
        "staging")
            container_name="cpp-docker-app-staging"
            ;;
        *)
            log_error "Unknown environment: $env"
            log_info "Available environments: dev, prod, staging"
            exit 1
            ;;
    esac
    
    log_info "Opening shell in $container_name"
    
    if docker ps | grep -q "$container_name"; then
        docker exec -it "$container_name" bash
    else
        log_error "Container $container_name is not running"
        log_info "Start the container first with: $0 run $env"
        exit 1
    fi
}

show_logs() {
    local service=${1:-"cpp-app"}
    
    cd "$SCRIPT_DIR"
    log_info "Showing logs for service: $service"
    docker compose logs -f "$service"
}

clean_up() {
    log_warning "This will remove all containers, images, and volumes"
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$SCRIPT_DIR"
        log_info "Cleaning up Docker resources"
        docker compose down --rmi all --volumes --remove-orphans
        log_success "Cleanup completed"
    else
        log_info "Cleanup cancelled"
    fi
}

run_tests() {
    cd "$SCRIPT_DIR"
    log_info "Running tests in container"
    docker compose --profile test up --build cpp-app-test
}

start_dev() {
    cd "$SCRIPT_DIR"
    log_info "Starting development environment"
    docker compose --profile dev up -d cpp-app-dev
    log_success "Development environment started"
    log_info "Access with: $0 shell dev"
}

stop_containers() {
    cd "$SCRIPT_DIR"
    log_info "Stopping all containers"
    docker compose down
    log_success "All containers stopped"
}

restart_service() {
    local service=${1:-"cpp-app"}
    
    cd "$SCRIPT_DIR"
    log_info "Restarting service: $service"
    docker compose restart "$service"
    log_success "Service $service restarted"
}

show_status() {
    cd "$SCRIPT_DIR"
    log_info "Docker Compose Services Status:"
    docker compose ps
    
    echo
    log_info "Docker Images:"
    docker images | grep cpp-docker-app || log_warning "No cpp-docker-app images found"
    
    echo
    log_info "Docker Volumes:"
    docker volume ls | grep "$(basename "$SCRIPT_DIR")" || log_warning "No project volumes found"
}

# Main script logic
case "${1:-help}" in
    "build")
        build_image "$2"
        ;;
    "run")
        run_app "$2"
        ;;
    "shell")
        open_shell "$2"
        ;;
    "logs")
        show_logs "$2"
        ;;
    "clean")
        clean_up
        ;;
    "test")
        run_tests
        ;;
    "dev")
        start_dev
        ;;
    "stop")
        stop_containers
        ;;
    "restart")
        restart_service "$2"
        ;;
    "status")
        show_status
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        log_error "Unknown command: $1"
        echo
        show_help
        exit 1
        ;;
esac