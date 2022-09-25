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

command=$1

if [ "$command" == "install" ]; then

  # Running this script as root
  run_as_root "$@"

  for url in "${@:2}"; do
    # Setting download directory variable
    download_directory="/var/cache/apt"

    # Creating download directory
    mkdir -p "$download_directory"

    # Setting file name variable
    file_name="$(basename "$url")"

    # Setting download file path variable
    download_file_path="${download_directory}/${file_name}"

    # Downloading deb file
    curl -L -o "$download_file_path" "$url"

    # Installing deb file
    apt install --assume-yes "$download_file_path"
  done
fi
