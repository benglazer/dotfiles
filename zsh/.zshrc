echo Running .zshrc

# zsh configurations
setopt auto_cd

# aliases
if [ -f "${HOME}/.bash_aliases" ]; then
    source "${HOME}/.bash_aliases"
fi
if [ -f "${HOME}/.zsh_aliases" ]; then
    source "${HOME}/.zsh_aliases"
fi


# The following lines were added by compinstall
zstyle :compinstall filename '/Users/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

