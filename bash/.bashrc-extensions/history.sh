#!/bin/bash

# Via https://sanctum.geek.nz/arabesque/better-bash-history/

# Append history instead of rewriting it
shopt -s histappend

# Allow a larger history file
HISTFILESIZE=1000000
HISTSIZE=1000000

# Filter out some commands from history
HISTCONTROL=ignoreboth  # Ignore commands that start with a space and dupes
HISTIGNORE='ls:bg:fg:history'  # Ignore common commands

# Add timestamps to history
HISTTIMEFORMAT='%F %T '

# One command per line
shopt -s cmdhist

# Store history immediately after each command; don't wait for end-of-session
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
