#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Removing no snap config file
rm /etc/apt/preferences.d/nosnap.pref

# Downloading package information from all configured sources
apt update

# Installing Snapd
apt-get install -y snapd