echo Running .zprofile

if [ -f ~/.profile ]; then
  source ~/.profile
fi

# aliases
if [ -r ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

# private bins
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi
