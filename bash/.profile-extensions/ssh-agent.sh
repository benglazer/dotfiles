#!/bin/bash

# Modified from https://web.archive.org/web/20220513101246/http://mah.everybody.org/docs/ssh

SSH_ENV="${HOME}/.ssh/ssh-agent-env"

function start_agent {
    echo -n "Initializing new SSH agent... "
    /usr/bin/ssh-agent | sed '/^echo/d' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    ssh-add || true
}

# Source SSH settings, if applicable
if [[ -f "${SSH_ENV}" ]]; then
    source "${SSH_ENV}"
    pgrep ssh-agent | grep "${SSH_AGENT_PID}" > /dev/null && echo "Using ssh-agent that's already running" || start_agent
else
    start_agent
fi
