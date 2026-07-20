#!/bin/bash

# Importing functions run_as_root, apt_download_install and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing requirements
apt_install apt-transport-https ca-certificates curl gnupg

# Adding repository public key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Adding repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' > /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/sources.list.d/kubernetes.list   

# Installing kubectl
apt_install kubectl

# Installing auto completion
kubectl completion bash > /etc/bash_completion.d/kubectl
chmod a+r /etc/bash_completion.d/kubectl

# Installing minikube
apt_download_install https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb