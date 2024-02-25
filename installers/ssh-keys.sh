#!/bin/bash

# Create new ssh keys
ssh-keygen -o -a 100 -t ed25519
ssh-keygen -t rsa -b 4096 -o -a 100
