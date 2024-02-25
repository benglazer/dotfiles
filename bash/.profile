#!/bin/bash

# Executed by the command interpreter for login shells. This file is not
# read by bash if ~/.bash_profile or ~/.bash_login exists.

echo Running .profile

# Source .bashrc if we're running bash and .bashrc exists
if [ -n "$BASH_VERSION" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
    	source "${HOME}/.bashrc"
    fi
fi

# Set PATH to include user's private/local bins if they exist
if [[ -d "${HOME}/bin" ]] ; then
    PATH="${HOME}/bin:${PATH}"
fi
if [[ -d "${HOME}/.local/bin" ]] ; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

# Load extensions
source "${HOME}/.profile-extensions/pyenv.sh"
source "${HOME}/.profile-extensions/ssh-agent.sh"
