#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Fazendo backup do arquivo anterior
cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Criando novo arquivo
{
  echo "{"
  echo "\"default-address-pools\":"
  echo "["
  echo "{\"base\":\"172.255.0.0/16\",\"size\":24}"
  echo "]"
  echo "}"
} > "/etc/docker/daemon.json"