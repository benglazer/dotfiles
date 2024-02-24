#!/bin/bash
set -euo pipefail  # https://gist.github.com/robin-a-meade/58d60124b88b60816e8349d1e3938615
IFS=$'\n\t'

# Bootstrap a new Ubuntu or MacOS computer. Assumes a minimalist OS
# installation as a starting point.


# Variables
REPO_URL="https://github.com/benglazer/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
DOTFILES_BACKUP="${HOME}/.dotfiles-backup"
STOW_TARGETS=(bash git vim)


# Ensure the script is run as a normal user, not root
if [ "$(id -u)" = "0" ]; then
   echo "This script should not be run as root. Please run it as a normal user, without sudo."
   exit 1
fi

install_dependencies() {
    # Install and update OS package managers
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Updating apt sources."
        sudo apt update && sudo apt upgrade
        echo "Installing new packages."
        sudo apt install git stow "linux-headers-$(uname -r)" build-essential dkms  # minimal requirements
        sudo xargs -a "${DOTFILES_DIR}/installers/apt-install.txt" sudo apt install -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Installing homebrew."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Installing new packages."
        brew install git stow  # minimal requirements
        brew bundle --file="${DOTFILES_DIR}/installers/Brewfile"
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
        echo "Dotfiles directory already exists. Pulling latest changes."
        git -C "${DOTFILES_DIR}" pull
    fi
}

backup_existing_dotfiles() {
    echo "Backing up existing dotfiles."
    cd "${DOTFILES_DIR}" || return
    for dotfile_group in "${STOW_TARGETS[@]}" ; do
        cd "${dotfile_group}" || return
        find . -type f -exec sh -c '
            if [[ -f "${HOME}/$1" ]] ; then
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
    stow "${STOW_GROUPS_TO_INSTALL[@]}"
}

main() {
    pushd . > /dev/null
    install_dependencies
    clone_dotfiles_repo
    backup_existing_dotfiles
    install_dotfiles
    popd > /dev/null || return
}

main
echo "Bootstrap complete. Reboot to verify everything is working as expected."
