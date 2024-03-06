# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"  # auto-activate virtualenvs

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
