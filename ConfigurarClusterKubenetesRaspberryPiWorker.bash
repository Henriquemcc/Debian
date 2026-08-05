#!/bin/bash

# Importing functions run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Habilitando cgroups
if ! [ -f '/boot/firmware/cmdline.txt' ]; then
    echo 'cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory' > /boot/firmware/cmdline.txt
fi

# Desativando partição swap
dphys-swapfile swapoff 2>/dev/null
systemctl disable dphys-swapfile 2>/dev/null
swapoff -a

# Instalando o K3s
K3S_HOSTNAME="$1"
K3S_TOKEN="$2"
curl -sfL https://get.k3s.io | K3S_URL=https://$K3S_HOSTNAME:6443 K3S_TOKEN=$K3S_TOKEN sh -