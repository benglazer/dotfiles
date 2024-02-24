#!/bin/bash

# Variables
REPO_URL="https://github.com/benglazer/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Ensure the script is run as a normal user, not root
if [ "$(id -u)" = "0" ]; then
   echo "This script should not be run as root. Please run it as a normal user, without sudo."
   exit 1
fi

# Install Xcode Command Line Tools on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  xcode-select --install
fi

# Install Git if not available
if ! command -v git &> /dev/null; then
    echo "Git could not be found. Attempting to install Git..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install git -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install git
    else
        echo "Cannot install Git. Unsupported OS."
        exit 1
    fi
fi

# Clone Dotfiles Repository
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo "Dotfiles directory already exists. Pulling latest changes..."
    git -C "$DOTFILES_DIR" pull
fi

echo "Bootstrap completed successfully."
