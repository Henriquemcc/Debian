#!/bin/bash

# Getting GITHUB_USERNAME environment variable
source .env

# Checking if GITHUB_USERNAME is set
if [ -z "$GITHUB_USERNAME" ]; then
    read -p "Enter your GitHub username: " GITHUB_USERNAME
    echo "GITHUB_USERNAME=$GITHUB_USERNAME" >> .env
fi

# Downloading ssh public keys
curl "https://github.com/${GITHUB_USERNAME}.keys" >> ~/.ssh/authorized_keys

# Defining permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
