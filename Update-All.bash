#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0" "$@"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Updating packages
apt update && apt full-upgrade -y
snap refresh
flatpak update -y

# Running again as root
run_as_root