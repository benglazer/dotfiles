#!/bin/bash

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then
    # GNU
    colorflag="--color"
else
    # MacOS
    colorflag="-G"
fi

# /bin & /usr/bin basics
alias ls='ls -F ${colorflag}'
alias ll='ls -la'
alias lh='ll -h'
alias l='ls'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias find='find .'

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# git
if command -v git > /dev/null; then
    alias g='git'
    alias gpush='git push origin'
    alias gpull='git pull origin'
    alias gst='git st'
    alias gdf='git df'
    alias gdfs='gdf --staged'
    alias gl='git l'
    alias ga='git add'
    alias gap='git add -p'
    alias gci='git commit -m'
    alias gco='git checkout'
    alias gbr='git branch'
    alias gf='git fetch --prune'
    alias gm='git merge'
    alias gg='git grep'
    alias gss='git stash save'
    alias gsp='git stash pop'
fi

# apt
if command -v apt-get > /dev/null; then
    alias apt='sudo apt'
    alias apt-get='sudo apt-get'
    alias agi='apt-get install'
    alias agu='apt-get update'
    alias agup='apt-get full-upgrade'
    alias acs='apt-cache search'
    alias acsh='apt-cache show'
    alias agrm='apt-get remove'
    alias apt-file='sudo apt-file'
fi

# dpkg
if command -v dpkg > /dev/null; then
    alias dg='dpkg -l | grep'
fi

# homebrew
if command -v brew > /dev/null; then
    alias b='brew'
    alias bi='brew info'
    alias bui='brew uses --installed'
    alias bun='brew uninstall'
    alias bl='brew list'
    alias bu='brew update'
    alias bup='brew upgrade --greedy'
fi

# docker
if command -v docker > /dev/null; then
    alias d='docker'
    alias dc='sudo docker-compose'
    alias docker='sudo docker'
    alias docker-compose='dc'
    alias docker-ip='docker inspect -f '\''{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\'''
fi

# task
if command -v task > /dev/null; then
    alias t="task"
    alias ta='t add'
    alias ts='t sync'
    alias tp='t +personal'
    alias te='t +eduvant'
fi

# tmux
if command -v tmux > /dev/null; then
    alias tmux='tmux -CC attach || tmux -CC'
fi

# fancy one-liners
alias webserver='python3 -m http.server'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'  # stopwatch
alias hfreq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'  # show 30 most commonly used commands from history
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
