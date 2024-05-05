# Enable pyenv
# Via https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
eval "$(pyenv init -)"


# Custom functions

latest_python() {
    # Return the latest stable version of python, matching a version prefix
    # if provided
    local version="${1:-3}"
    pyenv install -l | sed -nr "s/^  (${version}(\.[-\.0-9]+)?)$/\1/p" | tail -n 1
}

alias install_latest_python='brew upgrade pyenv pyenv-virtualenv && pyenv update && pyenv install --verbose --skip-existing $(latest_python)'

mkvenvhere() {
    env_name=${1:-$(basename $(pwd))}
    pyenv virtualenv $(latest_python) "${env_name}"
    pyenv local "${env_name}"
    if [ -f "requirements.txt" ]; then
        echo "requirements.txt found, installing packages..."
        pip install -r requirements.txt
    fi
}

# Check if latest python version is installed
check_latest_python_installed() {
    if pyenv versions --bare | grep -q "^$(latest_python)$"; then
        return 0  # Latest Python is installed, return true (0)
    else
        return 1  # Latest Python is not installed, return false (1)
    fi
}

# Check if "default" virtualenv is set to latest_python
check_latest_python_default() {
    if pyenv versions --bare | grep -q "^$(latest_python)/envs/default$"; then
        return 0  # Latest Python is installed, return true (0)
    else
        return 1  # Latest Python is not installed, return false (1)
    fi
}

# Ensure system default virtualenv and pip-installed packages are up-to-date
ensure_latest_python_default() {
    echo Ensuring pyenv is up-to-date
    pyenv update

    echo Ensuring the latest version of python is installed and set to the system default
    if ! check_latest_python_default; then
        if ! check_latest_python_installed; then
            # Install latest python version
            echo Installing python $(latest_python)
            pyenv install $(latest_python)
        fi

        echo Creating tmp virtualenv
        pyenv virtualenv $(latest_python) tmp
        pyenv activate tmp

        echo Recreating default virtualenv using python $(latest_python)
        pyenv uninstall -f default
        pyenv virtualenv $(latest_python) default
        pyenv activate default

        echo Cleaning up tmp virtualenv
        pyenv uninstall -f tmp
    fi

    if [ -f "${HOME}/requirements.txt" ]; then
        echo Installing/updating pip packages from "${HOME}/requirements.txt"
        pip install -U pip -r "${HOME}/requirements.txt"
    fi

    echo Ensuring that pyenv global is set to default
    if [[ $(pyenv global) != "default" ]]; then
        echo Global python env is set to \"$(pyenv global)\"\; updating to \"default\" instead
        pyenv global default
    fi
}
