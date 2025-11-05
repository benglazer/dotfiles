#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if ! command -v uv &> /dev/null; then
    echo "uv could not be found. Installing..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Pre-set to avoid interactive prompt from tzdata apt package
        sudo ln -fs /usr/share/zoneinfo/US/Central /etc/localtime

        # Via https://docs.astral.sh/uv/getting-started/installation/
        set +u
        curl -LsSf https://astral.sh/uv/install.sh | sh
        set -u
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install uv
    else
        echo "Cannot install uv: Unsupported OS."
        exit 1
    fi
fi

# Install the latest python version globally
source "${HOME}/.local/bin/env"
source "${HOME}/.profile-extensions/python.sh"
ensure_latest_python_default
