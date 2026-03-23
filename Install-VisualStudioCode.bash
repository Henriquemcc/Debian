#!/bin/bash

# Importing functions run_as_root and uninstall_rpm_package
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Exiting if Visual Studio Code is already installed
if [ "$(command -v code)" ]; then
  exit 0
fi

# Installing requirements
if [ "$(command -v apt)" ]; then
  DEBIAN_FRONTEND=noninteractive apt update
  DEBIAN_FRONTEND=noninteractive apt install -y curl gpg
elif [ "$(command -v apt-get)" ]; then
  DEBIAN_FRONTEND=noninteractive apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y curl gpg
fi

# Installing Visual Studio Code from DEB package
if [ "$(command -v apt)" ] || [ "$(command -v apt-get)" ]; then
  # Adding Microsoft key
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/vscode.gpg

  # Adding Microsoft Repository
  {
    echo "Types: deb"
    echo "URIs: https://packages.microsoft.com/repos/code"
    echo "Suites: stable"
    echo "Components: main"
    echo "Architectures: amd64 arm64 armhf"
    echo "Signed-By: /usr/share/keyrings/vscode.gpg"
  } > /etc/apt/sources.list.d/vscode.sources

  # Updating repository and installing Visual Studio Code
  if [ "$(command -v apt)" ]; then
    DEBIAN_FRONTEND=noninteractive apt update
    DEBIAN_FRONTEND=noninteractive apt-cache policy code
    DEBIAN_FRONTEND=noninteractive apt install -y code
  elif [ "$(command -v apt-get)" ]; then
    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-cache policy code
    DEBIAN_FRONTEND=noninteractive apt-get install -y code
  fi

# Installing Visual Studio Code from Snap package
else
  # Installing Snapd
  bash ./Install-Snapd.bash

  # Installing Visual Studio Code
  while true; do
    snap install code --classic && break
  done
fi
