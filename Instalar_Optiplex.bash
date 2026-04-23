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

    # Obtendo funções apt_download_install, apt_install e apt_uninstall
    source ./AptTools.bash

    # Configurando gerenciador de pacotes apt
    bash ./ConfigurarAptPackageManager.bash

    # Habilitando atualizações automáticas
    bash ./ConfigurarAtualizacoesAutomaticasUnattendedUpgrades.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.bash

    # Array de pacotes DEB
    declare -a deb_packages=()

    # Impressora HP
    deb_packages+=("hplip")

    # Instalando os Sistemas de arquivos não nativos do linux
    deb_packages+=("fuse")

    # Instalando outros programas
    deb_packages+=("sudo-rs")

    # Instalando o File Roller
    deb_packages+=("file-roller")
    deb_packages+=("file-roller-nautilus")

    # Instalando o Suporte a arquivos 7zip
    deb_packages+=("p7zip-plugins")
    deb_packages+=("p7zip")

    # Instalando ferramentas para manipular arquivos PDF
    deb_packages+=("imagemagick")
    deb_packages+=("pdftk-java")
    deb_packages+=("ocrmypdf")

    # Instalando outros programas
    deb_packages+=("vlc")
    deb_packages+=("youtube-dl")
    deb_packages+=("yt-dlp")
    deb_packages+=("ffmpeg")
    deb_packages+=("command-not-found")

    # Instalando pacotes DEB
    apt_install "${deb_packages[@]}"

    # Instalando o Draw.io
    apt_download_install "https://github.com/jgraph/drawio-desktop/releases/download/v29.6.1/drawio-amd64-29.6.1.deb"
  }

  # Instala pacotes snap
  function instalar_pacotes_snap() {

    # Instalando snapd
    bash ./Install-Snapd.bash
  }

  # Instala pacotes flatpak
  function instalar_pacotes_flatpak() {
    # Instalando o Flatpak
    bash ./Install-Flatpak.bash

    # Instalando o FlatHub
    bash ./Install-Flathub.bash

    # Instalando o BitWarden
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.bitwarden.desktop.flatpakref

    # Instalando o KeepassXC
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.keepassxc.KeePassXC.flatpakref

    # Instalando o Calibre
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.calibre_ebook.calibre.flatpakref

    # Instalando o Okular
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.kde.okular.flatpakref

    # Instalando o Audacity
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref

    # Instalando o Free File Sync
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.freefilesync.FreeFileSync.flatpakref
  }

  # Adicionando suporte ao NTFS e ao Ex-Fat (de preferência por módulo do Kernel)
  bash ./Enable-Ntfs.bash
  bash ./Enable-ExFat.bash

  # Configurando Systemd-Resolved
  bash ./ConfigurarSystemdResolved.bash

  # Desabilitando o sshd
  bash ./Disable-Sshd.bash

  # Configurando o Grub
  bash ./ConfigurarGrub.bash

  # Configurando o NTP
  bash ./ConfigurarNtp.bash

  # Instalando o Google Chrome
  bash ./Install-GoogleChromeStable.bash

  # Instalando pacotes apt
  instalar_pacotes_apt

  # Instalando Java
  bash ./Install-Java_8_Gui.bash
  bash ./Install-Java_21_Gui.bash
  bash ./Install-Java_21_Devel.bash

  # Instalando pacotes snap
  instalar_pacotes_snap

  # Instalando pacotes flatpak
  instalar_pacotes_flatpak

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o Peazip
  bash ./Install-Peazip.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown
}

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  if [ "$(command -v sudo-rs)" ]; then
    sudo-rs bash -c "$(declare -f run_as_root); run_as_root"
  else
    sudo bash -c "$(declare -f run_as_root); run_as_root"
  fi
fi
