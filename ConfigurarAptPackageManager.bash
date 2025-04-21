#!/bin/bash

# Importando funções run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Rodando como root
run_as_root

if [ "$(get_os_type)" == "debian" ]; then
  # Alterando o mirror para o mirror do Brasil
  sed -i 's/ftp.debian.org\/debian\//ftp.br.debian.org\/debian\//g' "/etc/apt/sources.list"
elif [ "$(get_os_type)" == "ubuntu" ]; then
  # Instalando pacotes necessários
  apt-get update
  apt-get install -y apt-transport-mirrors
  apt-get install -y apt-transport-https
  apt-get install -y apt-utils
  apt-get install -y apt-mirror

  # Alterando o mirror para a lista de mirrors do Brasil
  sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/BR.txt/g' "/etc/apt/sources.list"
  sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/BR.txt/g' "/etc/apt/sources.list.d/ubuntu.sources"

  # Alterando repositório de segurança para utilizar https ao invés de http
  sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//https:\/\/security.ubuntu.com\/ubuntu\//g' "/etc/apt/sources.list"
  sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//https:\/\/security.ubuntu.com\/ubuntu\//g' "/etc/apt/sources.list.d/ubuntu.sources"
fi

# Atualizando lista de pacotes
apt-get update
