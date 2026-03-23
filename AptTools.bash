#!/bin/bash

function apt_download_install() {

  # Updating repository and installing requirement
  DEBIAN_FRONTEND=noninteractive apt update
  DEBIAN_FRONTEND=noninteractive apt install -y curl

  # Downloading and installing packages
  for download_url in "$@" ; do
    download_dir="/tmp/apt/download/$(date "+%d-%m-%Y_%H:%M:%S")"
    mkdir -p "$download_dir" || exit
    download_filename="echo ${download_url##*/}"
    curl -L "$download_url" --output "$download_filename"
    DEBIAN_FRONTEND=noninteractive apt install -y "./$download_filename"
  done
}