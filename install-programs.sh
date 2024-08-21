#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to determine the package manager
detect_package_manager() {
    if command_exists apt; then
        echo "apt"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists yum; then
        echo "yum"
    else
        echo "No known package manager found"
        exit 1
    fi
}

# Function to install packages using the detected package manager
install_package() {
    local package="$1"
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y "$package"
            ;;
        dnf)
            sudo dnf install -y "$package"
            ;;
        yum)
            sudo yum install -y "$package"
            ;;
        *)
            echo "Unsupported package manager"
            exit 1
            ;;
    esac
}

# Detect the package manager
PACKAGE_MANAGER=$(detect_package_manager)
echo "Detected package manager: $PACKAGE_MANAGER"

# Update package list
echo "Updating package list..."
case $PACKAGE_MANAGER in
    apt)
        sudo apt update
        ;;
    dnf)
        sudo dnf check-update
        ;;
    yum)
        sudo yum check-update
        ;;
esac

# Install zsh if not already installed
if ! command_exists zsh; then
    echo "Installing zsh..."
    install_package zsh
else
    echo "zsh is already installed."
fi

# Install tmux if not already installed
if ! command_exists tmux; then
    echo "Installing tmux..."
    install_package tmux
else
    echo "tmux is already installed."
fi

# Install git if not already installed
if ! command_exists git; then
    echo "Installing git..."
    install_package git
else
    echo "git is already installed."
fi

# Install neovim if not already installed
if ! command_exists nvim; then
    echo "Installing neovim..."
    install_package neovim
else
    echo "neovim is already installed."
fi
