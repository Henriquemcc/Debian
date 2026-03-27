#!/bin/bash

# Importing function run_as_root, apt_download_install and apt_install
source RunAsRoot.bash
source OsInfo.bash
source AptTools.bash

# Running as root
run_as_root

# Getting the version of Debian
source /etc/os-release

# Installing Microsoft repository GPG keys
apt_download_install "https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb"

# Installing PowerShell
apt_install powershell
