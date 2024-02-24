#!/bin/bash

# Variables
REPO_URL="https://github.com/benglazer/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
PLAYBOOK_PATH="$DOTFILES_DIR/playbook.yml"

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

# Install Ansible if not available
if ! command -v ansible &> /dev/null; then
    echo "Ansible could not be found. Attempting to install Ansible..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install ansible -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ansible
    else
        echo "Cannot install Ansible. Unsupported OS."
        exit 1
    fi
fi

# Run Ansible Playbook
if [ -f "$PLAYBOOK_PATH" ]; then
    ansible-playbook "$PLAYBOOK_PATH"
else
    echo "Cannot find Ansible playbook at $PLAYBOOK_PATH."
    exit 1
fi

echo "Bootstrap completed successfully."
