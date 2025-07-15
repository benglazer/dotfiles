echo Running .profile

# Executed by the command interpreter for login shells. Ensure all additions
# are compatible with both bash and zsh (or execute them conditionally). This
# file is not executed by bash if ~/.bash_profile or ~/.bash_login exists.

# Source .bashrc if we're running bash and .bashrc exists
# (zsh automatically sources .zshrc, so no need to call it here)
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

# homebrew
if command -v brew > /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load extensions
source "${HOME}/.profile-extensions/python.sh"
source "${HOME}/.profile-extensions/ssh-agent.sh"
