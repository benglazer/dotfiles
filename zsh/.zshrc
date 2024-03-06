# zsh configurations
setopt auto_cd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/benglazer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
