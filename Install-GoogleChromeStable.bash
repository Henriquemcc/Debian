#!/bin/bash

# Importing functions run_as_root and apt_download_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing Google Chrome
apt_download_install https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb