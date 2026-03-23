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

    # Instalando o KVM
    deb_packages+=("qemu-kvm")
    deb_packages+=("libvirt")

    # Instalando os Sistemas de arquivos não nativos do linux
    deb_packages+=("fuse")

    # Instalando outros programas
    deb_packages+=("sudo-rs")

    # Instalando ferramentas de segurança
    deb_packages+=("chkrootkit")
    deb_packages+=("lynis")

    # Instalando outros programas
    deb_packages+=("mokutil")

    # Instalando o File Roller
    deb_packages+=("file-roller")
    deb_packages+=("file-roller-nautilus")

    # Instalando o Suporte a arquivos 7zip
    deb_packages+=("p7zip-plugins")
    deb_packages+=("p7zip")

    # Instalando as Ferramentas de desenvolvimento
    deb_packages+=("golang")
    deb_packages+=("gcc")
    deb_packages+=("gcc-c++")
    deb_packages+=("dotnet-sdk-5.0")
    deb_packages+=("aspnetcore-runtime-5.0")
    deb_packages+=("dotnet-runtime-5.0")
    deb_packages+=("git")
    deb_packages+=("git-lfs")
    deb_packages+=("adb")
    deb_packages+=("libstdc++-devel")
    deb_packages+=("perf")
    deb_packages+=("python3-pip")
    deb_packages+=("python-is-python3")
    deb_packages+=("python3-devel")

    # Instalando ferramentas para manipular arquivos PDF
    deb_packages+=("imagemagick")
    deb_packages+=("pdftk-java")
    deb_packages+=("ocrmypdf")

    # Instalando outros programas
    deb_packages+=("vlc")
    deb_packages+=("stacer")
    deb_packages+=("qt5-qtcharts")
    deb_packages+=("libdvdcss")
    deb_packages+=("qt5-qtsvg")
    deb_packages+=("youtube-dl")
    deb_packages+=("yt-dlp")
    deb_packages+=("ffmpeg")
    deb_packages+=("fdupes")
    deb_packages+=("gwakeonlan")
    deb_packages+=("brasero")
    deb_packages+=("rclone")
    deb_packages+=("wireshark")
    deb_packages+=("detox")
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

    # Instalando pacotes snap
    while true; do
      snap install spotify && break
    done

    while true; do
      snap install intellij-idea-community --classic && break
    done

    while true; do
      snap install pycharm-community --classic && break
    done

    while true; do
      snap install flutter --classic && break
    done

    while true; do
      snap install kotlin --classic && break
    done
    
    while true; do
      snap install postman && break
    done

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

    # Instalando o OnlyOffice
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.onlyoffice.desktopeditors.flatpakref

    # Instalando o LibreOffice
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.libreoffice.LibreOffice.flatpakref

    # Instalando o Gimp
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gimp.GIMP.flatpakref

    # Instalando o Gedit
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gnome.gedit.flatpakref

    # Instalando o Calibre
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.calibre_ebook.calibre.flatpakref

    # Instalando o Okular
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.kde.okular.flatpakref

    # Instalando o Audacity
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref

    # Instalando o RetroArch
    flatpak install --assumeyes https://flathub.org/repo/appstream/org.libretro.RetroArch.flatpakref

    # Instalando o Signal
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref

    # Instalando o Free File Sync
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.freefilesync.FreeFileSync.flatpakref

    # Instalando o Discord
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref

    # Instalando o Dconf Editor
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/ca.desrt.dconf-editor.flatpakref
    
    # Instalando o Stremio
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.stremio.Stremio.flatpakref
    
    # Instalando Gnome Clock
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gnome.clocks.flatpakref

    # Instalando o Packet (Quick-Share)
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/io.github.nozwock.Packet.flatpakref

    # Instalando o Steam
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref

    # Instalando o Hytale
    flatpak install --assumeyes https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak

    # Instalando o qbittorrent
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.qbittorrent.qBittorrent.flatpakref
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

  # Instalando o Visual Studio Code
  bash ./Install-VisualStudioCode.bash

  # Instalando o PowerShell
  bash ./Install-PowerShell.bash

  # Instalando o Balena Etcher
  bash ./Install-BalenaEtcher.bash

  # Instalando o Unity Hub
  bash ./Install-UnityHub.bash

  # Instalando pacotes apt
  instalar_pacotes_apt

  # Instalando Java
  bash ./Install-Java_8_Gui.bash
  bash ./Install-Java_21_Gui.bash
  bash ./Install-Java_21_Devel.bash

  # Instalando o Wireguard
  bash ./Install-Wireguard.bash

  # Instalando pacotes snap
  instalar_pacotes_snap

  # Instalando pacotes flatpak
  instalar_pacotes_flatpak

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o Docker
  bash ./Install-DockerDesktop.bash

  # Configurando o Docker
  bash ./ConfigurarDocker.bash

  # Instalando o VirtualBox
  bash ./Install-OracleVirtualBox.bash
  bash ./Sign-VirtualBox.bash
  bash ./ConfigurarVirtualbox.bash

  # Instalando o Peazip
  bash ./Install-Peazip.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown

  # Instalando GitHub Cli
  bash ./Install-GithubCli.bash
}

# Configurando o Gnome Shell
bash ./ConfigurarGnomeShell.bash

# Configurando o Git
bash ./ConfigurarGit.bash

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.bash

# Instalando o Ffmpeg
bash ./Install-Ffmpeg.bash

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

# Baixando chaves públicas ssh
bash ./Get-SshPublicKeysFromGithub.bash