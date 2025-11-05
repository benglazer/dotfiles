#!/bin/bash

LATEST_NVM=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | sed -n 's/.*"tag_name": *"\(v[^"]*\)".*/\1/p')

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$LATEST_NVM/install.sh | bash

# Activate nvm in this script's environment
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install the latest LTS Node.js version as default
nvm install --lts --default
