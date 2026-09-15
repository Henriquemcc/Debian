#!/bin/bash

# Importing function run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing Unattended Upgrades package
apt_install unattended-upgrades

# Backup the original configuration files
cp "/etc/apt/apt.conf.d/50unattended-upgrades" "/etc/apt/apt.conf.d/50unattended-upgrades.backup.$(date "+%d-%m-%Y_%H:%M:%S")"
cp "/etc/apt/apt.conf.d/20auto-upgrades" "/etc/apt/apt.conf.d/20auto-upgrades.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Configuring Unattended Upgrades
{
    echo "Unattended-Upgrade::Allowed-Origins {"
	echo "        \"\${distro_id}:\${distro_codename}\";"
	echo "        \"\${distro_id}:\${distro_codename}-security\";"
	echo "        \"\${distro_id}ESMApps:\${distro_codename}-apps-security\";"
	echo "        \"\${distro_id}ESM:\${distro_codename}-infra-security\";"
	echo "        \"\${distro_id}:\${distro_codename}-updates\";"
	echo "        \"\${distro_id}:\${distro_codename}-backports\";"
    echo "};"

    echo "Unattended-Upgrade::Package-Blacklist {"
    echo "};"

    echo "Unattended-Upgrade::DevRelease \"auto\";"
    echo "Unattended-Upgrade::AutoFixInterruptedDpkg \"true\";"
    echo "Unattended-Upgrade::MinimalSteps \"true\";"
    echo "Unattended-Upgrade::Remove-Unused-Kernel-Packages \"true\";"
    echo "Unattended-Upgrade::Remove-New-Unused-Dependencies \"true\";"
    echo "Unattended-Upgrade::Remove-Unused-Dependencies \"true\";"
    echo "Unattended-Upgrade::Automatic-Reboot \"true\";"
    echo "Unattended-Upgrade::Automatic-Reboot-WithUsers \"false\";"
    echo "Unattended-Upgrade::Skip-Updates-On-Metered-Connections \"true\";"

} > "/etc/apt/apt.conf.d/50unattended-upgrades"

# Configuring automatic updates
{
    echo "APT::Periodic::Update-Package-Lists \"1\";"
    echo "APT::Periodic::Unattended-Upgrade \"1\";"
} > "/etc/apt/apt.conf.d/20auto-upgrades"

# Enabling Unattended Upgrades
systemctl enable --now unattended-upgrades.service

# Restarting Unattended Upgrades service
systemctl restart unattended-upgrades.service