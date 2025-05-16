#!/bin/bash

# Importando funções run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Rodando como root
run_as_root

# Variáveis
country_mirror=br

function alterar_country_mirror() {
  if [ "$(get_os_type)" == "debian" ]; then
    sed -i "s/deb.debian.org\/debian/ftp.${country_mirror}.debian.org\/debian/g" "/etc/apt/sources.list"
    sed -i "s/deb.debian.org\/debian/ftp.${country_mirror}.debian.org\/debian/g" "/etc/apt/sources.list.d/debian.sources"

  elif [ "$(get_os_type)" == "ubuntu" ]; then
    sed -i "s/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/${country_mirror^^}.txt/g" "/etc/apt/sources.list"
    sed -i "s/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/${country_mirror^^}.txt/g" "/etc/apt/sources.list.d/ubuntu.sources"
  fi
}

function substituir_http_por_https() {
  if [ "$(get_os_type)" == "ubuntu" ]; then
    sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//https:\/\/security.ubuntu.com\/ubuntu\//g' "/etc/apt/sources.list"
    sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//https:\/\/security.ubuntu.com\/ubuntu\//g' "/etc/apt/sources.list.d/ubuntu.sources"
  fi
}

function instalar_complementos_apt()
{
  DEBIAN_FRONTEND=noninteractive apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-mirrors || true
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https || true
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils || true
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-mirror || true
}

# Configurando APT
instalar_complementos_apt
alterar_country_mirror
substituir_http_por_https

# Atualizando lista de pacotes
DEBIAN_FRONTEND=noninteractive apt-get update