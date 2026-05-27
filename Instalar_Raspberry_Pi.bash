#!/bin/bash

# Importando funções apt_install e apt_download_install
source AptTools.bash

# Executa instalação como root
function run_as_root() {

  function instalar_pacotes_apt() {

    # Array de pacotes DEB
    declare -a deb_packages=()

    # Sistemas de arquivos não nativos do linux
    deb_packages+=("fuse")

    # Comando para completar comandos no terminal
    deb_packages+=("bash-completion")

    # Podman
    deb_packages+=("podman")

    # Podman-Docker
    deb_packages+=("podman-docker")

    # Instalando pacotes DEB
    apt_install "${deb_packages[@]}"

    # Instalando Dynamic DNS Update Client
    apt_download_install https://github.com/Henriquemcc/Dynamic_DNS_Update_Client/releases/download/v1.1.0/dynamic-dns-update-client_0-1_all.deb
  }

  # Carregando dados do arquivo .env
  source .env

  # Configurando Systemd-Resolved
  bash ./ConfigurarSystemdResolved.bash

  # Configurando o sshd_config
  bash ./ConfigurarSshdConfig.bash

  # Configurando APT
  bash ./ConfigurarAptPackageManager.bash

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Alterando o nome do computador
  hostnamectl set-hostname --static "$hostname_raspberry_pi"

  # Habilitando o RPM Fusion
  bash ./Enable-RpmFusion.bash

  # Configurando o NTP
  bash ./ConfigurarNtpRaspiberry.bash

  # Configurando Unattended Upgrades
  bash ./ConfigurarAtualizacoesAutomaticasUnattendedUpgrades.bash.bash

  # Instalando pacotes dnf
  instalar_pacotes_apt

  # Instalando Java
  bash ./Install-Java_21_Headless.bash

  # Instalando o Wireguard
  bash ./Wireguard/Install-Wireguard.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash
}

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi

# Baixando chaves públicas ssh
bash ./Get-SshPublicKeysFromGithub.bash