# Dev container for C++ development with CMake and Conan
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and development tools
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    cmake \
    ninja-build \
    gdb \
    lldb \
    valgrind \
    # Python for Conan
    python3 \
    python3-pip \
    python3-venv \
    # Version control and utilities
    git \
    curl \
    wget \
    unzip \
    zip \
    # Text editors and utilities
    vim \
    nano \
    tree \
    # Development tools
    clang \
    clang-format \
    clang-tidy \
    cppcheck \
    # Network tools for debugging
    net-tools \
    iputils-ping \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Conan
RUN pip3 install conan

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to the vscode user
USER $USERNAME

# Set up Conan profile for the user
RUN conan profile detect --force

# Set the default working directory
WORKDIR /workspace

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog