#!/bin/bash

version="2.1.4"
download_url="https://github.com/balena-io/etcher/releases/download/v${version}/balena-etcher_${version}_amd64.deb"

# Importing function run_as_root and apt_download_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing Balena Etcher
apt_download_install "$download_url"