# Custom functions

# Create a venv in the current directory
mkvenvhere() {
  local ver="${1:-3}"  # default to latest 3.x
  uv venv --python "$ver"
  if [[ -f requirements.txt ]]; then
    echo "requirements.txt found, installing packages..."
    uv pip install -r requirements.txt
  elif [[ -f pyproject.toml ]]; then
    echo "pyproject.toml found, installing packages..."
    uv sync  # lock + install
  fi
  uv python pin  # writes .python-version
}


# Ensure system default virtualenv and pip-installed packages are up-to-date
ensure_latest_python_default() {
  echo Ensuring uv is up-to-date
  case "$OSTYPE" in
    linux-gnu*)
      uv self update
      ;;
    darwin*)
      brew upgrade uv
      ;;
    *)
      echo "Unsupported OS. Cannot continue."
      exit 1
      ;;
  esac

  echo Ensuring python is up-to-date and set to the system default
  uv python install 3 --default --preview
  uv python upgrade

  if [[ -f "${HOME}/requirements.txt" ]]; then
    echo "requirements.txt found, installing packages..."
    uv pip install -r requirements.txt
  elif [[ -f "${HOME}/pyproject.toml" ]]; then
    echo "pyproject.toml found, installing packages..."
    uv sync  # lock + install
  fi
}
