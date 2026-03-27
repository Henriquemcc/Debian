#!/bin/bash

# Importing functions run_as_root and apt_uninstall
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Disabling sshd service
systemctl disable --now sshd

# Removing ssh from firewall
ufw delete allow 22/tcp
ufw delete allow 22/udp

# Uninstalling sshd
apt_uninstall openssh-server