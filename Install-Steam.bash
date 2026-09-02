#!/bin/bash

# Importing function run_as_root and apt_download_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Downloading and installing Steam
apt_download_install https://repo.steampowered.com/steam/archive/precise/steam_latest.deb