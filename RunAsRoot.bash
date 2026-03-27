#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo-rs)" ]; then
      sudo-rs  bash "$0" "$@"
      exit $?
    elif [ "$(command -v sudo)" ]; then
      sudo bash "$0" "$@"
      exit $?
    else
      echo "Sudo and sudo-rs are not installed"
      exit 1
    fi
  fi
}