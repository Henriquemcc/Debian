#!/bin/bash

# Configurando o armazenamento de credenciais
git config --global credential.helper store

# Criando o comando 'git hist'
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

# Definindo a branch principal como 'main'
git config --global init.defaultBranch main

# Configurando o Visual Studio Code como o editor padrão
git config --global core.editor "code --wait"