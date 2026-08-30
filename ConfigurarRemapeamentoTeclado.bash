#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Instalando requisitos
apt install -y cargo

# Instalando programa que remapeia teclado
cargo install xremap --features gnome

# Copiando o binário para a pasta /usr/local/bin/
executable_file_path="/usr/local/bin/xremap"
cp /root/.cargo/bin/xremap "$executable_file_path"

# Configurando o remapeamento do teclado
keyboard_mapper_file="/etc/xremap/keyboard.yml"
mkdir -p "$(dirname $keyboard_mapper_file)"
if ! [ -f "$keyboard_mapper_file" ]; then
  {
    echo "modmap:"
    echo "  - name: Left Key replacement"
    echo "    remap:"
    echo "      KEY_RIGHTALT: KEY_LEFT"
  } > "$keyboard_mapper_file"
fi

# Criando serviço no Systemd
service_name="remapear-teclado.service"
service_file_path="/etc/systemd/system/${service_name}"
{
  echo "[Unit]"
  echo "Description=Remapeamento do teclado utilizando o xremap"
  echo
  echo "[Service]"
  echo "Type=simple"
  echo "ExecStart=${executable_file_path} ${keyboard_mapper_file}"
  echo "Restart=on-failure"
  echo
  echo "[Install]"
  echo "WantedBy=multi-user.target"
} > "$service_file_path"

# Recarregando systemd para reconhecer o novo serviço
systemctl daemon-reload

# Habilitando e iniciando serviço
systemctl enable remapear-teclado.service
systemctl start remapear-teclado.service