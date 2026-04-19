#!/bin/bash

# Importando funções run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Rodando como root
run_as_root

# Instalando complementos do APT
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y apt-transport-https || true
apt-get install -y apt-utils || true

# Definindo o mirror do Ubuntu
country_mirror=br
if [ "$(get_os_type)" == "ubuntu" ]; then
  sed -i "s/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/${country_mirror^^}.txt/g" "/etc/apt/sources.list"
  sed -i "s/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/${country_mirror^^}.txt/g" "/etc/apt/sources.list.d/ubuntu.sources"
fi

# Atualizando lista de pacotes
apt-get update