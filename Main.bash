#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 6 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Executar instalação padrão"
    echo "2 - Atualizar o sistema"
    echo "3 - Configurar o sistema"
    echo "4 - Instalar pacote"
    echo "5 - Limpar o sistema"
    echo "6 - Reparar"
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
    bash ./Instalar.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Atualizar.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Configurar.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./InstalarPacotes.bash
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./Limpar.bash
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./Reparar.bash
  fi
done
