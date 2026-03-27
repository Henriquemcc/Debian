#!/bin/bash

# Importing function run_as_root, get_os_type and apt_install
source RunAsRoot.bash
source OsInfo.bash
source AptTools.bash

function sign_virtualbox_modules() {
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"

    path_virtualbox_modules_directory="$(dirname "$(modinfo -n vboxdrv)")"

    # For each file in the VirtualBox kernel module directory
    for file_path_in_virtualbox_modules_directory in "$path_virtualbox_modules_directory"/*; do

      # Decompressing XZ file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".xz" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        eval "$command_to_sign_kernel_module"
        xz --decompress --keep "$file_path_in_virtualbox_modules_directory"
        file_path_in_virtualbox_modules_directory="${file_path_in_virtualbox_modules_directory::-3}"
      fi

      # Signing .ko file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".ko" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        eval "$command_to_sign_kernel_module"
      fi

    done

  fi

}

# Running as root
run_as_root

# Installing requirements
apt_install kmod coreutils "linux-headers-$(uname -r)" linux-libc-dev dkms libqt5x11extras5-dev libelf-dev zlib1g-dev build-essential

# Installing kernel uek devel for Oracle Linux
if [ "$(get_os_type)" == "ol" ]; then
  dnf install --assumeyes kernel-uek-devel
  dnf install --assumeyes kernel-uek-devel-"$(uname -r)"
fi

sign_virtualbox_modules

# Unloading KVM kernel modules
modprobe -r kvm_intel kvm

# Loading VirtualBox kernel modules
modprobe vboxdrv

# Rebuilding kernel akmod packages
akmods

# Restarting VirtualBox service
systemctl restart vboxdrv.service

# Configuring VirtualBox
/sbin/vboxconfig
