FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get full-upgrade -y && apt-get install -y \
    git \
    # curl \
    # zsh \
    # python3 \
    # python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Optional: Setup a non-root user (for environments where this is relevant)
RUN useradd -m -s /bin/bash testuser && echo "testuser:testuser" | chpasswd && adduser testuser sudo
USER testuser
WORKDIR /home/testuser

# Clone your dotfiles repository
RUN git clone https://github.com/benglazer/dotfiles.git
WORKDIR dotfiles

# Run your dotfiles installation script
RUN ./bootstrap.sh

# Set the default command to zsh (or bash, depending on your preference)
CMD ["zsh"]
