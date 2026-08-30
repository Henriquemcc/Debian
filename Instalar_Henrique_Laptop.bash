#!/bin/bash

# Realizando processo comum de instalacao
bash ./Instalar_Henrique_PC.bash

# Executa instalação como root
function run_as_root() {
  # Alterando o nome do computador
  hostnamectl set-hostname --static henrique-laptop
  hostnamectl set-hostname --pretty HENRIQUE-LAPTOP

  # Configurando o remapeamento do teclado
  bash ./ConfigurarRemapeamentoTeclado.bash
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
