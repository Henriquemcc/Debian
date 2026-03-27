#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Realizando backup das configurações
cp "/etc/default/grub" "/etc/default/grub.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Gerando novo arquivo de configuração
# Salvando a última opção
if ! grep -q "GRUB_SAVEDEFAULT=true" "/etc/default/grub"; then
  echo "GRUB_SAVEDEFAULT=true" >> "/etc/default/grub"
fi

# Permitindo que o grub detecte outros sistemas operacionais e outras distros
if ! grep -q "GRUB_DISABLE_OS_PROBER=false" "/etc/default/grub"; then
  echo "GRUB_DISABLE_OS_PROBER=false" >> "/etc/default/grub"
fi

# Gerando grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg