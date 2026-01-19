#!/bin/bash

#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 43 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Docker Engine"
    echo "2 - Dynamic DNS Update Client (Duck DNS)"
    echo "3 - Flatpak"
    echo "4 - Compilador de Java 8"
    echo "5 - Compilador de Java 11"
    echo "6 - Compilador de Java 17"
    echo "7 - Compilador de Java 21"
    echo "8 - Java 8 (com interface gráfica)"
    echo "9 - Java 11 (com interface gráfica)"
    echo "10 - Java 17 (com interface gráfica)"
    echo "11 - Java 21 (com interface gráfica)"
    echo "12 - Java 8 (sem interface gráfica)"
    echo "13 - Java 11 (sem interface gráfica)"
    echo "14 - Java 17 (sem interface gráfica)"
    echo "15 - Java 21 (sem interface gráfica)"
    echo "16 - Snapd"

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
    bash ./Install-DockerEngine.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Install-Dynamic_Dns_Update_Client.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Install-Flatpak.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./Install-Java_8_Devel.bash
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./Install-Java_11_Devel.bash
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./Install-Java_17_Devel.bash
  elif [ "$opcao_selecionada" -eq 7 ]; then
    bash ./Install-Java_21_Devel.bash
  elif [ "$opcao_selecionada" -eq 8 ]; then
    bash ./Install-Java_8_Gui.bash
  elif [ "$opcao_selecionada" -eq 9 ]; then
    bash ./Install-Java_11_Gui.bash
  elif [ "$opcao_selecionada" -eq 10 ]; then
    bash ./Install-Java_17_Gui.bash
  elif [ "$opcao_selecionada" -eq 11 ]; then
    bash ./Install-Java_21_Gui.bash
  elif [ "$opcao_selecionada" -eq 12 ]; then
    bash ./Install-Java_8_Headless.bash
  elif [ "$opcao_selecionada" -eq 13 ]; then
    bash ./Install-Java_11_Headless.bash
  elif [ "$opcao_selecionada" -eq 14 ]; then
    bash ./Install-Java_17_Headless.bash
  elif [ "$opcao_selecionada" -eq 15 ]; then
    bash ./Install-Java_21_Headless.bash
  elif [ "$opcao_selecionada" -eq 16 ]; then
    bash ./Install-Snapd.bash
  fi
done
