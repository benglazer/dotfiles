#!/bin/bash
set -euo pipefail  # https://gist.github.com/robin-a-meade/58d60124b88b60816e8349d1e3938615
IFS=$'\n\t'

# Bootstrap a new Ubuntu or MacOS computer. Assumes a minimalist OS
# installation as a starting point.


# Variables
REPO_URL="https://github.com/benglazer/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
DOTFILES_BACKUP="${HOME}/.dotfiles-backup"
STOW_TARGETS=(bash git vim zsh)


# Ensure the script is run as a normal user, not root
if [ "$(id -u)" = "0" ]; then
   echo "This script should not be run as root. Please run it as a normal user, without sudo."
   exit 1
fi

install_dependencies() {
    # Install and update OS package managers
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Updating apt sources."
        sudo apt-get update && sudo apt-get upgrade -y
        echo "Installing minimal dependencies."
        sudo apt-get install -y git stow
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Installing homebrew."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Activating homebrew."
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo "Installing minimal dependencies."
        brew install git stow
    else
        echo "Unsupported OS. Cannot continue."
        exit 1
    fi
}

clone_dotfiles_repo() {
    if [ ! -d "${DOTFILES_DIR}" ]; then
        echo "Cloning dotfiles git repo from ${REPO_URL}"
        git clone "${REPO_URL}" "${DOTFILES_DIR}"
    else
        echo "Using existing dotfiles directory."
    fi
}

backup_existing_dotfiles() {
    echo "Backing up existing dotfiles."
    cd "${DOTFILES_DIR}" || return
    for dotfile_group in "${STOW_TARGETS[@]}" ; do
        cd "${dotfile_group}" || return
        find . -type f -exec sh -c '
            if [ -f "${HOME}/$1" ] ; then
                mkdir -pv "$(dirname "$2/${dotfile_group}/$1")"
                mv -v "${HOME}/$1" \
                      "$2/${dotfile_group}/$1"
            fi' shell {} "${DOTFILES_BACKUP}" \;
        cd .. || return
    done
}

install_dotfiles() {
    echo "Installing dotfiles via stow."
    cd "${DOTFILES_DIR}" || return
    stow "${STOW_TARGETS[@]}"
}

install_optional_packages() {
    echo "Installing new packages."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo xargs -a "${DOTFILES_DIR}/installers/apt-install.txt" sudo apt-get install -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew bundle --file="${DOTFILES_DIR}/installers/Brewfile"
    fi
}

post_install_config() {
    git config --global core.excludesfile "${HOME}/.gitignore"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        git config --global credential.helper "osxkeychain"
    fi
}

run_installers() {
    echo "Running installers."
    source "${DOTFILES_DIR}/installers/ssh.sh"
    source "${DOTFILES_DIR}/installers/python.sh"
}

main() {
    pushd . > /dev/null
    install_dependencies
    clone_dotfiles_repo
    backup_existing_dotfiles
    install_dotfiles
    install_optional_packages
    post_install_config
    run_installers
    popd > /dev/null || return
}

main
echo "Bootstrap complete. Reboot to verify everything is working as expected."
