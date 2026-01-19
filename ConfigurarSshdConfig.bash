#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Open SSH Server
apt install --assumeyes openssh-server

# Backing up configuration file
cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "Include /etc/ssh/sshd_config.d/*.conf"
  echo "PubkeyAuthentication yes"
  echo "AuthorizedKeysFile	.ssh/authorized_keys"
  echo "PasswordAuthentication no"
  echo "Subsystem	sftp	/usr/libexec/openssh/sftp-server"
} > "/etc/ssh/sshd_config"

# Restarting sshd
systemctl restart sshd