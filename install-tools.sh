#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Update package list
echo "Updating package list..."
sudo apt update

# Install diff-so-fancy
if ! command_exists diff-so-fancy; then
    echo "Installing diff-so-fancy..."

    # Create a local bin directory if it does not exist
    LOCAL_BIN="$HOME/.local/bin"
    mkdir -p "$LOCAL_BIN"

    # Download the latest release
    LATEST_RELEASE=$(curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    DOWNLOAD_URL="https://github.com/so-fancy/diff-so-fancy/releases/download/${LATEST_RELEASE}/diff-so-fancy"

    # Download and install
    curl -Lo "$LOCAL_BIN/diff-so-fancy" "$DOWNLOAD_URL"
    chmod +x "$LOCAL_BIN/diff-so-fancy"

    # Add local bin directory to PATH
    if ! grep -q "$LOCAL_BIN" "$HOME/.zshrc"; then
        echo "Adding $LOCAL_BIN to PATH in ~/.zshrc..."
        echo "export PATH=\"\$PATH:$LOCAL_BIN\"" >> "$HOME/.zshrc"
        source "$HOME/.zshrc"
    fi

    # Configure git to use diff-so-fancy
    echo "Configuring Git to use diff-so-fancy..."
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
    git config --global interactive.diffFilter "diff-so-fancy --patch"

else
    echo "diff-so-fancy is already installed."
fi

# Install exa
if ! command_exists exa; then
    echo "Installing exa..."
    
    # Install Rust and cargo if not present
    if ! command_exists cargo; then
        echo "Installing Rust and Cargo..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
    fi

    cargo install exa
else
    echo "exa is already installed."
fi

# Install Nerd Fonts
FONT_DIR="$HOME/.local/share/fonts"
NERD_FONTS_VERSION="2.1.0"
NERD_FONTS_ARCHIVE="DroidSansMono.zip"
NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/${NERD_FONTS_ARCHIVE}"

if [ ! -f "$FONT_DIR/Droid Sans Mono Nerd Font Complete.otf" ]; then
    echo "Installing Nerd Fonts..."
    mkdir -p "$FONT_DIR"
    wget -O "$FONT_DIR/$NERD_FONTS_ARCHIVE" "$NERD_FONTS_URL"
    unzip "$FONT_DIR/$NERD_FONTS_ARCHIVE" -d "$FONT_DIR"
    rm "$FONT_DIR/$NERD_FONTS_ARCHIVE"
else
    echo "Nerd Fonts are already installed."
fi

# Refresh font cache
echo "Refreshing font cache..."
fc-cache -fv

echo "Installation complete."
