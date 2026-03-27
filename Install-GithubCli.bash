#!/bin/bash

# Importing function run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing requirements
apt_install curl

# Adding public key
mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /etc/apt/keyrings/githubcli-archive-keyring.gpg

# Adding repository
mkdir -p -m 755 /etc/apt/sources.list.d
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list

# Installing GitHub CLI
apt_install gh