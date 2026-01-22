#!/bin/bash

# Getting GITHUB_USERNAME environment variable
source .env

# Downloading ssh public keys
curl "https://github.com/${GITHUB_USERNAME}.keys" >> ~/.ssh/authorized_keys

# Defining permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
