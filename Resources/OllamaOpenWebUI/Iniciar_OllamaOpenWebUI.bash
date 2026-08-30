#!/bin/bash

# -------------------------------------------------
# Configurações
# -------------------------------------------------
container_name="open-webui"

# Detecta se há GPU NVIDIA
if lspci | grep -i nvidia > /dev/null; then
    gpu_present=true
    container_image="ghcr.io/open-webui/open-webui:cuda"
else
    gpu_present=false
    container_image="ghcr.io/open-webui/open-webui:main"
fi

# -------------------------------------------------
# Inicia o servidor Ollama em background
# -------------------------------------------------
ollama serve &

# -------------------------------------------------
# Baixa a imagem do container
# -------------------------------------------------
docker pull "$container_image"

# -------------------------------------------------
# Monta os argumentos do docker run
# -------------------------------------------------
run_args=(
    -d                       # detached
    --network=host
    -v open-webui:/app/backend/data
    --name "$container_name"
    --restart unless-stopped
    -e OLLAMA_BASE_URL=http://127.0.0.1:11434
)

# Só adiciona a flag de GPU se houver GPU detectada
if $gpu_present; then
    run_args+=(--gpus all)
fi

# -------------------------------------------------
# Cria o container caso ainda não exista
# -------------------------------------------------
if ! docker ps -a --format '{{.Names}}' | grep -wq "$container_name"; then
    docker run "${run_args[@]}" "$container_image"
fi

# -------------------------------------------------
# Garante que o container esteja em execução
# -------------------------------------------------
if ! docker ps --format '{{.Names}}' | grep -wq "$container_name"; then
    docker start "$container_name"
fi

# -------------------------------------------------
# Abre o navegador apontando para a UI
# -------------------------------------------------
xdg-open "http://localhost:8080"