#!/bin/bash

# Instalação de pacotes no sistema
function run_as_root() {

  # Instalando Docker
  if ! [ "$(command -v docker)" ]; then
    bash ./Install-DockerEngine.bash
  fi

  # Instalando ollama
  snap install ollama

  # Instalando Nvidia Container
  bash ./Install-NvidiaContainer.bash
}

# Executando instalação de pacotes no sistema
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  if [ "$(command -v sudo-rs)" ]; then
    sudo-rs bash -c "$(declare -f run_as_root); run_as_root"
  else
    sudo bash -c "$(declare -f run_as_root); run_as_root"
  fi
fi

# Copiando script de inicialização
path_script_inicializacao="$HOME/.bin/Iniciar_OllamaOpenWebUI.bash"
mkdir -p "$(dirname "$path_script_inicializacao")"
cp "Resources/OllamaOpenWebUI/Iniciar_OllamaOpenWebUI.bash" "$path_script_inicializacao"
chmod +x "$path_script_inicializacao"

# Baixando logo do Ollama
path_logo="$HOME/.local/share/icons/hicolor/181x256/ollama.png"
mkdir -p "$(dirname "$path_logo")"
curl -L "https://ollama.com/public/ollama.png" -o "$path_logo"

# Criando atalho para iniciar o container
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Ollama + OpenWebUI"
  echo "GenericName=Ollama + OpenWebUI"
  echo "Exec=bash \"$path_script_inicializacao\""
  echo "Icon=$path_logo"
  echo "Terminal=false"
  echo "Keywords=ollama; open; web; ui;"
  echo "StartupNotify=true"
} > "$HOME/.local/share/applications/OpenWebUI.desktop"

# Baixando modelos
ollama serve &
ollama pull deepseek-r1
ollama pull gpt-oss
ollama pull mistral
