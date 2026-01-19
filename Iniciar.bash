#!/bin/bash

# Salvando o path anterior
path_old_current_dir="$(pwd)"

# Baixando o arquivo zip do repositório
url_file="https://github.com/Henriquemcc/Debian/archive/refs/heads/main.tar.gz"
path_download_file="/tmp/Debian_main.zip"
curl -L "$url_file" > "$path_download_file"

# Extraíndo arquivo tar
tar -xzf "$path_download_file" -C "/tmp"

# Entrando dentro da pasta
cd "/tmp/Debian-main" || exit 1

# Executando script
bash ./Executar.bash

# Voltando ao caminho anterior
cd "$path_old_current_dir" || exit 1