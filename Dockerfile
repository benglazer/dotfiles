FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get full-upgrade -y && apt-get install -y \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set up a non-root user "testuser" for testing
RUN adduser --disabled-password testuser
RUN echo 'testuser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/testuser
RUN chmod 400 /etc/sudoers.d/testuser

# Activate the testuser
USER testuser
WORKDIR /home/testuser

# Run the dotfiles bootstrap script
RUN curl -L https://raw.githubusercontent.com/benglazer/dotfiles/master/bootstrap.sh | bash

# Set the default command to bash
CMD ["bash"]
