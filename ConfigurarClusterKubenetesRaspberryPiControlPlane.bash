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
curl -sfL https://get.k3s.io | sh -

# Source - https://stackoverflow.com/a/7359006
# Posted by Michał Šrajer, modified by community. See post 'Timeline' for change history
# Retrieved 2026-08-04, License - CC BY-SA 3.0
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

# Configurando o kubectl para uso sem sudo
sudo -u "$SUDO_USER" mkdir -p $USER_HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $USER_HOME/.kube/config
chown "$SUDO_USER" "$USER_HOME/.kube/config"
echo "export KUBECONFIG=$USER_HOME/.kube/config" >> $USER_HOME/.bashrc
chown "$SUDO_USER" "$USER_HOME/.bashrc"

# Imprimindo endereço IP
echo "Endereço IP: "
hostname -I
echo

# Imprimindo token
echo "Token: "
cat /var/lib/rancher/k3s/server/node-token
echo