#!/bin/bash

# Importing function run_as_root, apt_download_install and apt_install
source RunAsRoot.bash
source OsInfo.bash
source AptTools.bash

# Running as root
run_as_root

# Installing requirements
apt_install wget apt-transport-https software-properties-common

# Getting the version of Debian
source /etc/os-release

# Installing Microsoft repository GPG keys
OS_TYPE="$(get_os_type)"
apt_download_install "https://packages.microsoft.com/config/$OS_TYPE/$VERSION_ID/packages-microsoft-prod.deb"

# Installing PowerShell
apt_install powershell
