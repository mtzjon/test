#!/bin/bash

##############################################################################
# Code Quality Script for C++ Docker Project
# 
# This script provides convenient commands for running code quality tools:
# - clang-format for code formatting
# - clang-tidy for static analysis
# - doxygen for documentation generation
##############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project directories
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${PROJECT_ROOT}/build"

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}   C++ Docker Project - Code Quality${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

print_usage() {
    echo "Usage: $0 [COMMAND]"
    echo
    echo "Commands:"
    echo "  format        Format code with clang-format"
    echo "  format-check  Check code formatting"
    echo "  lint          Run clang-tidy static analysis"
    echo "  lint-fix      Run clang-tidy with automatic fixes"
    echo "  docs          Generate documentation with Doxygen"
    echo "  docs-open     Generate and open documentation"
    echo "  check-all     Run all quality checks"
    echo "  fix-all       Format code and apply lint fixes"
    echo "  install-deps  Install required tools (Ubuntu/Debian)"
    echo "  help          Show this help message"
    echo
}

check_tool() {
    local tool=$1
    local package=$2
    
    if command -v "$tool" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $tool found: $(command -v "$tool")"
        return 0
    else
        echo -e "${RED}✗${NC} $tool not found"
        if [ -n "$package" ]; then
            echo "  Install with: sudo apt install $package"
        fi
        return 1
    fi
}

check_dependencies() {
    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    local all_ok=true
    
    check_tool "clang-format" "clang-format" || all_ok=false
    check_tool "clang-tidy" "clang-tidy" || all_ok=false
    check_tool "doxygen" "doxygen" || all_ok=false
    
    echo
    
    if [ "$all_ok" = true ]; then
        echo -e "${GREEN}All dependencies are available!${NC}"
        return 0
    else
        echo -e "${YELLOW}Some dependencies are missing. Run '$0 install-deps' to install them.${NC}"
        return 1
    fi
}

install_dependencies() {
    echo -e "${YELLOW}Installing code quality tools...${NC}"
    
    # Check if we're on Ubuntu/Debian
    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y clang-format clang-tidy doxygen graphviz
        echo -e "${GREEN}Dependencies installed successfully!${NC}"
    else
        echo -e "${RED}Automatic installation only supported on Ubuntu/Debian systems.${NC}"
        echo "Please install the following tools manually:"
        echo "  - clang-format"
        echo "  - clang-tidy"
        echo "  - doxygen"
        echo "  - graphviz (optional, for diagrams)"
        exit 1
    fi
}

ensure_build_dir() {
    if [ ! -d "$BUILD_DIR" ]; then
        echo -e "${YELLOW}Creating build directory...${NC}"
        mkdir -p "$BUILD_DIR"
    fi
}

format_code() {
    echo -e "${YELLOW}Formatting code with clang-format...${NC}"
    
    if ! command -v clang-format >/dev/null 2>&1; then
        echo -e "${RED}clang-format not found!${NC}"
        exit 1
    fi
    
    find "$PROJECT_ROOT/src" "$PROJECT_ROOT/include" \
        -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" \
        | xargs clang-format -i
    
    echo -e "${GREEN}Code formatting completed!${NC}"
}

check_format() {
    echo -e "${YELLOW}Checking code format...${NC}"
    
    if ! command -v clang-format >/dev/null 2>&1; then
        echo -e "${RED}clang-format not found!${NC}"
        exit 1
    fi
    
    local format_issues=false
    
    while IFS= read -r -d '' file; do
        if ! clang-format --dry-run --Werror "$file" >/dev/null 2>&1; then
            echo -e "${RED}Format issues found in: $file${NC}"
            format_issues=true
        fi
    done < <(find "$PROJECT_ROOT/src" "$PROJECT_ROOT/include" \
        -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" \
        -print0)
    
    if [ "$format_issues" = true ]; then
        echo -e "${RED}Code format check failed! Run '$0 format' to fix.${NC}"
        exit 1
    else
        echo -e "${GREEN}Code format check passed!${NC}"
    fi
}

run_lint() {
    echo -e "${YELLOW}Running clang-tidy static analysis...${NC}"
    
    if ! command -v clang-tidy >/dev/null 2>&1; then
        echo -e "${RED}clang-tidy not found!${NC}"
        exit 1
    fi
    
    ensure_build_dir
    cd "$BUILD_DIR"
    
    # Configure CMake if needed
    if [ ! -f "CMakeCache.txt" ]; then
        echo -e "${YELLOW}Configuring CMake...${NC}"
        cmake ..
    fi
    
    # Run clang-tidy
    clang-tidy \
        --config-file="$PROJECT_ROOT/.clang-tidy" \
        --header-filter='(src|include)/.*\.h(pp)?$' \
        $(find "$PROJECT_ROOT/src" "$PROJECT_ROOT/include" \
            -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp") \
        -- \
        -I"$PROJECT_ROOT/include" \
        -std=c++17
    
    echo -e "${GREEN}Static analysis completed!${NC}"
}

run_lint_fix() {
    echo -e "${YELLOW}Running clang-tidy with automatic fixes...${NC}"
    
    if ! command -v clang-tidy >/dev/null 2>&1; then
        echo -e "${RED}clang-tidy not found!${NC}"
        exit 1
    fi
    
    ensure_build_dir
    cd "$BUILD_DIR"
    
    # Configure CMake if needed
    if [ ! -f "CMakeCache.txt" ]; then
        echo -e "${YELLOW}Configuring CMake...${NC}"
        cmake ..
    fi
    
    # Run clang-tidy with fixes
    clang-tidy \
        --config-file="$PROJECT_ROOT/.clang-tidy" \
        --header-filter='(src|include)/.*\.h(pp)?$' \
        --fix \
        $(find "$PROJECT_ROOT/src" "$PROJECT_ROOT/include" \
            -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp") \
        -- \
        -I"$PROJECT_ROOT/include" \
        -std=c++17
    
    echo -e "${GREEN}Automatic fixes applied!${NC}"
}

generate_docs() {
    echo -e "${YELLOW}Generating documentation with Doxygen...${NC}"
    
    if ! command -v doxygen >/dev/null 2>&1; then
        echo -e "${RED}doxygen not found!${NC}"
        exit 1
    fi
    
    ensure_build_dir
    cd "$BUILD_DIR"
    
    # Configure CMake if needed
    if [ ! -f "CMakeCache.txt" ]; then
        echo -e "${YELLOW}Configuring CMake...${NC}"
        cmake ..
    fi
    
    # Generate documentation
    make docs
    
    echo -e "${GREEN}Documentation generated in ${BUILD_DIR}/docs/html/${NC}"
}

open_docs() {
    generate_docs
    
    echo -e "${YELLOW}Opening documentation...${NC}"
    
    local doc_file="${BUILD_DIR}/docs/html/index.html"
    
    if [ -f "$doc_file" ]; then
        # Try different ways to open the browser
        if command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$doc_file"
        elif command -v open >/dev/null 2>&1; then
            open "$doc_file"
        elif command -v start >/dev/null 2>&1; then
            start "$doc_file"
        else
            echo -e "${YELLOW}Cannot open browser automatically. Please open: $doc_file${NC}"
        fi
    else
        echo -e "${RED}Documentation file not found: $doc_file${NC}"
        exit 1
    fi
}

check_all() {
    echo -e "${YELLOW}Running all quality checks...${NC}"
    echo
    
    check_format
    echo
    run_lint
    echo
    
    echo -e "${GREEN}All quality checks completed!${NC}"
}

fix_all() {
    echo -e "${YELLOW}Applying all automatic fixes...${NC}"
    echo
    
    format_code
    echo
    run_lint_fix
    echo
    
    echo -e "${GREEN}All fixes applied!${NC}"
}

# Main script logic
case "${1:-help}" in
    format)
        print_header
        format_code
        ;;
    format-check)
        print_header
        check_format
        ;;
    lint)
        print_header
        run_lint
        ;;
    lint-fix)
        print_header
        run_lint_fix
        ;;
    docs)
        print_header
        generate_docs
        ;;
    docs-open)
        print_header
        open_docs
        ;;
    check-all)
        print_header
        check_all
        ;;
    fix-all)
        print_header
        fix_all
        ;;
    install-deps)
        print_header
        install_dependencies
        ;;
    help|--help|-h)
        print_header
        print_usage
        ;;
    *)
        print_header
        echo -e "${RED}Unknown command: $1${NC}"
        echo
        print_usage
        exit 1
        ;;
esac