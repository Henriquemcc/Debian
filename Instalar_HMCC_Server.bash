#!/bin/bash

# Executa instalação como root
function run_as_root() {

  # Instala o script Wait-ForPidToShutdown.bash
    function instalar_script_wait_for_pid_to_shutdown() {
        file_name="Wait-ForPidToShutdown.bash"
        destination="/bin/$file_name"
        cp "./$file_name" "$destination"
        chmod +x "$destination"
    }

    #  Instala o script Update-All.bash
    function instalar_script_update_all() {
      file_name="Update-All.bash"
      destination="/bin/$file_name"
      cp "./$file_name" "$destination"
      chmod +x "$destination"
    }

  # Instala pacotes apt
  function instalar_pacotes_apt() {

    # Atualizando lista de pacotes
    apt update

    # Instalando os programas para sincronização
    apt install --assumeyes rsync
    apt install --assumeyes git
    apt install --assumeyes git-lfs
  }

  # Carregando dados do arquivo .env
  source .env

  # Adicionando suporte ao NTFS e ao Ex-Fat (de preferência por módulo do Kernel)
  bash ./Enable-Ntfs.bash
  bash ./Enable-ExFat.bash

  # Configurando o sshd_config
  bash ./ConfigurarSshdConfig.bash

  # Configurando Systemd-Resolved
  bash ./ConfigurarSystemdResolved.bash

  # Configurando APT
  bash ./ConfigurarAptPackageManager.bash

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Alterando o nome do computador
  hostnamectl set-hostname --static "$hostname_hmcc_server"

  # Configurando o NTP
  bash ./ConfigurarNtp.bash

  # Configurando Unattended Upgrades
  bash ./ConfigurarAtualizacoesAutomaticasUnattendedUpgrades.bash

  # Instalando pacotes apt
  instalar_pacotes_apt

  # Instalando o Flatpak
  bash ./Install-Flatpak.bash

  # Instalando o Snap
  bash ./Install-Snapd.bash

  # Instalando Java
  bash ./Install-Java_8_Headless.bash
  bash ./Install-Java_21_Headless.bash

  # Instalando o Docker
  bash ./Install-DockerEngine.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown
}

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
  bash -c "$(declare -f run_as_root); run_as_root"
else
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi