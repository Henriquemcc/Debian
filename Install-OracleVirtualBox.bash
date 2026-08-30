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
repository_string="deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
repository_file_path="/etc/apt/sources.list.d/oracle-virtualbox.list"
if ! grep -q "$repository_string" "$repository_file_path"; then
  echo "$repository_string" >> "$repository_file_path"
fi

# Adding public key
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

# Installing VirtualBox
apt_install virtualbox-7.1