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

# Read the programs.txt file and install packages if not already installed
while IFS= read -r package; do
    if ! command_exists "$package"; then
        echo "Installing $package..."
        install_package "$package"
    else
        echo "$package is already installed."
    fi
done < programs.txt

# Install oh-my-zsh
ZSH_DIR="$HOME/.oh-my-zsh"

# Check if the ZSH directory already exists
if [ -d "$ZSH_DIR" ]; then
    echo "Oh My Zsh is already installed in $ZSH_DIR. No action needed."
else
    # Run the installation script if the directory does not exist
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh installation complete."
fi
