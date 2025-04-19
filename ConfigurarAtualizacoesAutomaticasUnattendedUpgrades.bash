#!/bin/bash

# Importando função run_as_root
source RunAsRoot.bash

# Rodando como root
run_as_root

# Instalando Unattended Upgrades
apt-get update
apt-get install -y unattended-upgrades

# Habilitando Unattended Upgrades
systemctl enable --now unattended-upgrades.service