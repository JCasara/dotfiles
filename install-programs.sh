#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update package list
echo "Updating package list..."
sudo apt update

# Install zsh if not already installed
if ! command_exists zsh; then
    echo "Installing zsh..."
    sudo apt install -y zsh
else
    echo "zsh is already installed."
fi

# Install tmux if not already installed
if ! command_exists tmux; then
    echo "Installing tmux..."
    sudo apt install -y tmux
else
    echo "tmux is already installed."
fi

# Install git if not already installed
if ! command_exists git; then
    echo "Installing git..."
    sudo apt install -y git
else
    echo "git is already installed."
fi

# Install neovim if not already installed
if ! command_exists nvim; then
    echo "Installing neovim..."
    sudo apt install -y neovim
else
    echo "neovim is already installed."
fi
