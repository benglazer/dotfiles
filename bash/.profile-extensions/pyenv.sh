#!/bin/bash

if [[ -x ~/.pyenv/libexec/pyenv ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    set +u
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    set -u
fi

# Custom functions

latest_python_stable() {
    pyenv install -l | sed -nr 's/^  ([\.0-9]+)$/\1/p' | tail -n 1
}

latest_python2_stable() {
    pyenv install -l | sed -nr 's/^  (2\.[\.0-9]+)$/\1/p' | tail -n 1
}

latest_python3_stable() {
    pyenv install -l | sed -nr 's/^  (3\.[\.0-9]+)$/\1/p' | tail -n 1
}

alias latest_python=latest_python_stable

alias install_latest_python='brew upgrade pyenv pyenv-virtualenv && pyenv update && pyenv install --verbose --skip-existing $(latest_python_stable)'

mkvenvhere() {
    env_name=${1:-$(basename $(pwd))}
    pyenv virtualenv $(latest_python_stable) "${env_name}"
    pyenv local "${env_name}"
}

# Check if latest_python_stable is installed
check_latest_python_installed() {
    if pyenv versions --bare | grep -q "^$(latest_python_stable)$"; then
        return 0  # Latest Python is installed, return true (0)
    else
        return 1  # Latest Python is not installed, return false (1)
    fi
}

# Check if "default" virtualenv is set to latest_python_stable
check_latest_python_default() {
    if pyenv versions --bare | grep -q "^$(latest_python_stable)/envs/default$"; then
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
            echo Installing python $(latest_python_stable)
            pyenv install $(latest_python_stable)
        fi

        echo Creating tmp virtualenv
        pyenv virtualenv $(latest_python_stable) tmp
        pyenv activate tmp

        echo Recreating default virtualenv using python $(latest_python_stable)
        pyenv uninstall -f default
        pyenv virtualenv $(latest_python_stable) default
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
