#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Disabling Systemd Resolved
systemctl disable --now systemd-resolved.service

# Removing symbolic link
rm /etc/resolv.conf

# Creating symbolic link
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Restarting Network Manager
systemctl restart NetworkManager
