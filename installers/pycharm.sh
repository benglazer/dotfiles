#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v pycharm-community &> /dev/null; then
        echo "pycharm-community could not be found. Installing..."

        # Pre-set to avoid interactive prompt from tzdata apt package
        sudo apt install libsquashfuse0 squashfuse fuse snapd
        sudo snap install pycharm-community --classic
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install pycharm-ce
else
    echo "Cannot install PyCharm: Unsupported OS."
    exit 1
fi
