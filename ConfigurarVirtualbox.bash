#!/bin/bash

# Importing function get_os_type
source OsInfo.bash

# Criando atalho personalizado do VirtualBox para que o VirtualBox possa executar sem o erro causado pelo KVM
if [ "$(get_os_type)" == "fedora" ]; then
  cp /usr/share/applications/virtualbox.desktop ~/.local/share/applications/virtualbox.desktop
  sed -i "s|Exec=VirtualBox %U|Exec=/bin/bash -c \"pkexec env DISPLAY=\$DISPLAY XAUTHORITY=\$XAUTHORITY modprobe -r kvm_intel kvm; VirtualBox %U\"|" ~/.local/share/applications/virtualbox.desktop
fi