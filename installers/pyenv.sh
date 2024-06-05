#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if ! command -v pyenv &> /dev/null; then
    echo "pyenv could not be found. Attempting to install pyenv..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Pre-set to avoid interactive prompt from tzdata apt package
        sudo ln -fs /usr/share/zoneinfo/US/Central /etc/localtime

        # Via https://github.com/pyenv/pyenv/wiki/Common-build-problems
        sudo apt-get install -y \
            build-essential \
            curl \
            make \
            libbz2-dev \
            liblzma-dev \
            libncurses5-dev \
            libncursesw5-dev \
            libreadline-dev \
            libsqlite3-dev \
            libssl-dev \
            llvm \
            tk-dev \
            wget \
            xz-utils \
            zlib1g-dev

        # Via https://github.com/pyenv/pyenv-installer
        set +u
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        set -u
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install pyenv pyenv-virtualenv
    else
        echo "Cannot install pyenv: Unsupported OS."
        exit 1
    fi
fi

# Initialize pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Set default global env to latest python version
source "${HOME}/.profile-extensions/pyenv.sh"
ensure_latest_python_default
