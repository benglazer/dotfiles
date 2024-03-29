#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get install -y apt-transport-https

    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    sudo apt-get update
    sudo apt-get install -y sublime-text
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install sublime-text
fi
