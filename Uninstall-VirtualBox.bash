#!/bin/bash

# Importing function run_as_root and apt_uninstall
source RunAsRoot.bash
source AptTools.bash

# Uninstalling VirtualBox
apt_uninstall virtualbox virtualbox-dkms virtualbox-source