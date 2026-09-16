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
mkdir -p "/backup/etc/apt/apt.conf.d"
if [ -f "/etc/apt/apt.conf.d/50unattended-upgrades" ]; then
    cp "/etc/apt/apt.conf.d/50unattended-upgrades" \
       "/backup/etc/apt/apt.conf.d/50unattended-upgrades.backup.${TIMESTAMP}"
fi
if [ -f "/etc/apt/apt.conf.d/20auto-upgrades" ]; then
    cp "/etc/apt/apt.conf.d/20auto-upgrades" \
       "/backup/etc/apt/apt.conf.d/20auto-upgrades.backup.${TIMESTAMP}"
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

    # Distro repositories
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
        # Third-party repositories with a proper origin:archive pair (via apt-cache policy)
        echo "        \"Google LLC:stable\";"              # Google Chrome (dl.google.com)
        echo "        \"code stable:stable\";"              # Visual Studio Code (packages.microsoft.com)
        echo "        \"Docker:\${distro_codename}\";"      # Docker CE (download.docker.com) - archive tracks the distro codename

    echo "};"

    # Third-party repositories without a Suite/Archive field in their Release file
    # (Allowed-Origins requires an origin:archive pair, so these need Origins-Pattern instead)
    echo "Unattended-Upgrade::Origins-Pattern {"
    echo "        \"site=hub.unity3d.com\";"                                  # Unity Hub
    echo "        \"origin=gh\";"                                             # GitHub CLI (cli.github.com)
    echo "        \"origin=Oracle Corporation,site=download.virtualbox.org\";" # VirtualBox
    echo "        \"site=download.opensuse.org,label=isv:Rancher:stable\";"   # Rancher Desktop
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