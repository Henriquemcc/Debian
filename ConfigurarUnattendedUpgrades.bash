#!/bin/bash

# Importing function run_as_root, apt_install and get_os_type
source RunAsRoot.bash
source AptTools.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing Unattended Upgrades package
apt_install unattended-upgrades

# Backup the original configuration files
TIMESTAMP=$(date "+%d-%m-%Y_%H:%M:%S")
if [ -f "/etc/apt/apt.conf.d/50unattended-upgrades" ]; then
    cp "/etc/apt/apt.conf.d/50unattended-upgrades" \
       "/etc/apt/apt.conf.d/50unattended-upgrades.backup.${TIMESTAMP}"
fi
if [ -f "/etc/apt/apt.conf.d/20auto-upgrades" ]; then
    cp "/etc/apt/apt.conf.d/20auto-upgrades" \
       "/etc/apt/apt.conf.d/20auto-upgrades.backup.${TIMESTAMP}"
fi

# Configuring Unattended Upgrades
{
    echo "Unattended-Upgrade::Allowed-Origins {"

    # Getting the OS type
    os_type="$(get_os_type)"

    # Normalizing OS type for Linux Mint, Pop!_OS, Raspbian, and Kali Linux
    if [ "$os_type" = "linuxmint" ] || [ "$os_type" = "pop" ]; then
        os_type="ubuntu"
    elif [ "$os_type" = "raspbian" ] || [ "$os_type" = "kali" ]; then
        os_type="debian"
    fi

    if [ "$os_type" = "ubuntu" ]; then
        echo "        \"\${distro_id}:\${distro_codename}\";"
        echo "        \"\${distro_id}:\${distro_codename}-security\";"
        echo "        \"\${distro_id}ESMApps:\${distro_codename}-apps-security\";"
        echo "        \"\${distro_id}ESM:\${distro_codename}-infra-security\";"
        echo "        \"\${distro_id}:\${distro_codename}-updates\";"
        echo "        \"\${distro_id}:\${distro_codename}-backports\";"
    elif [ "$os_type" = "debian" ]; then
        echo "        \"origin=Debian,codename=\${distro_codename}-updates\";"
        echo "        \"origin=Debian,codename=\${distro_codename},label=Debian\";"
        echo "        \"origin=Debian,codename=\${distro_codename},label=Debian-Security\";"
        echo "        \"origin=Debian,codename=\${distro_codename}-security,label=Debian-Security\";"
        echo "        \"origin=Debian,codename=\${distro_codename}-backports,label=Debian-Backports\";"
    fi
    echo "};"

    echo "Unattended-Upgrade::Package-Blacklist {"
    echo "};"

    echo "Unattended-Upgrade::DevRelease \"auto\";"
    echo "Unattended-Upgrade::AutoFixInterruptedDpkg \"true\";"
    echo "Unattended-Upgrade::MinimalSteps \"true\";"
    echo "Unattended-Upgrade::Remove-Unused-Kernel-Packages \"true\";"
    echo "Unattended-Upgrade::Remove-New-Unused-Dependencies \"true\";"
    echo "Unattended-Upgrade::Remove-Unused-Dependencies \"true\";"
    echo "Unattended-Upgrade::Automatic-Reboot \"false\";"
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