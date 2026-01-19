#!/bin/bash

# Importing functions run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Function that verifies if the system is compatible with NTFS3 Linux Kernel Module
function is_kernel_compatible_with_ntfs3_module() {

  # Minimum required version for the module ntfs3
  minimal_kernel_version="5.15"

  # Get current kernel version (only the version, no suffix)
  current_kernel_version=$(uname -r | cut -d- -f1)

  # Checking if kernel version is >= 5.15
  if [ "$(printf '%s\n' "$minimal_kernel_version" "$current_kernel_version" | sort -V | head -n1)" = "$minimal_kernel_version" ]; then
    kernel_config_path="/boot/config-$(uname -r)"

    # Checking if kernel configuration folder exists
    if [ -f "$kernel_config_path" ]; then

      # Checking if NTFS3 module is supported
      if grep -q '^CONFIG_NTFS3_FS=m' "$kernel_config_path"; then
        echo 1

      else
        echo 0
      fi
    else
      echo 0
    fi
  else
    echo 0
  fi
}

# Creating initialization file
if [ "$(is_kernel_compatible_with_ntfs3_module)" == 1 ]; then
  load_modules_folder="/etc/modules-load.d/"
  mkdir -p "$load_modules_folder"
  echo "ntfs3" > "$load_modules_folder/ntfs3.conf"
  modprobe ntfs3

# Installing ntfs-3g
else
  apt install -y ntfs-3g
fi
