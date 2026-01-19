#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 5 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Instalar configuração padrão ao gerenciador de pacotes APT"
    echo "2 - Instalar configuração padrão ao Unattended Upgrades"
    echo "3 - Configurar Systemd Resolved"
    echo "4 - Configurar sshd_config"
    echo "5 - Configurar NTP"
    read -r _opcao_selecionada
  done

  function_return_variable="$_opcao_selecionada"
}

opcao_selecionada=-1
while [ $opcao_selecionada -ne 0 ]; do

  # Obtendo opção selecionada pelo usuário
  obter_opcao
  opcao_selecionada="$function_return_variable"

  if [ "$opcao_selecionada" -eq 1 ]; then
    bash ./ConfigurarAptPackageManager.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./ConfigurarAtualizacoesAutomaticasUnattendedUpgrades.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./ConfigurarSystemdResolved.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./ConfigurarSshdConfig.bash
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./ConfigurarNtp.bash
  fi

done
