FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get full-upgrade -y && apt-get install -y \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Setup a non-root user for testing
RUN useradd -m -s /bin/bash testuser && echo "testuser:testuser" | chpasswd && adduser testuser sudo
USER testuser
WORKDIR /home/testuser

# Run your dotfiles installation script
RUN curl -L https://raw.githubusercontent.com/benglazer/dotfiles/master/bootstrap.sh | bash

# Set the default command to zsh (or bash, depending on your preference)
CMD ["bash"]
