#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Getting OS Type
os_type=$(get_os_type)

# Add Docker's official GPG key:
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL "https://download.docker.com/linux/${os_type}/gpg" -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${os_type} $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Installing Docker Engine
DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enabling Docker
systemctl enable --now docker containerd.service

# Adding user group
groupadd docker
usermod -aG docker "$SUDO_USER"

# Configuring to run in rootless mode
DEBIAN_FRONTEND=noninteractive apt-get -y install fuse-overlayfs uidmap
sudo -u "$SUDO_USER" dockerd-rootless-setuptool.sh install