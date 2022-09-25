#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root

# Installing Flatpak
apt install flatpak --assume-yes

# Installing the Flatpak plugin
apt install gnome-software-plugin-flatpak --assume-yes

# Adding FlatHub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo