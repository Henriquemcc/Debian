#!/bin/bash

# Importing functions run_as_root and apt_download_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing Docker Engine
bash ./Install-DockerEngine.bash

# Installing Docker desktop
apt_download_install https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
