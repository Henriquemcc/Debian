#!/bin/bash

# Verifying if xrandr is already installed
if [ "$(command -v xrandr)" ]; then
  exit
fi

# Importing function run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing xrandr
apt_install x11-xserver-utils