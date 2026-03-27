#!/bin/bash

# Installs Wireguard to both server and client

# Importing functions run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing Wireguard
apt_install wireguard