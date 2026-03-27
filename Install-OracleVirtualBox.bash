#!/bin/bash

# Importing function run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Installing requirements
apt_install curl gpg

# Adding repository
if ! grep -q "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbo" /etc/apt/sources.list; then
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbo" > /etc/apt/sources.list
fi

# Adding public key
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

# Installing VirtualBox
apt_install virtualbox-7.1