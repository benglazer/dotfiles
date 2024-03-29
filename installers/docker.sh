#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # via https://docs.docker.com/engine/install/ubuntu/

  # Update the apt package index and install packages to allow apt to use a repository over HTTPS
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg lsb-release

  # Add Docker’s official GPG key
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  # Set up the repository and update the package cache
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install Docker engine with Docker Compose
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi
