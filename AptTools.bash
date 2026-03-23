#!/bin/bash

function apt_download_install() {

  # Updating repository and installing requirement
  if [ "$(command -v apt)" ]; then
    DEBIAN_FRONTEND=noninteractive apt update
    DEBIAN_FRONTEND=noninteractive apt install -y curl
  elif [ "$(command -v apt-get)" ]; then
    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl
  fi

  # Downloading and installing packages
  for download_url in "$@" ; do
    download_dir="/tmp/apt/download/$(date "+%d-%m-%Y_%H:%M:%S")"
    mkdir -p "$download_dir" || exit
    download_filename="echo ${download_url##*/}"
    curl -L "$download_url" --output "$download_filename"
    if [ "$(command -v apt)" ]; then
      DEBIAN_FRONTEND=noninteractive apt install -y "./$download_filename"
    elif "[ $(command -v apt-get)" ]; then
      DEBIAN_FRONTEND=noninteractive apt-get install -y "./$download_filename"
    elif [ "$(command -v dpkg)" ]; then
      DEBIAN_FRONTEND=noninteractive dpkg -i "./$download_filename"
    fi
  done
}

function apt_install() {

  # Updating repositories
  if [ "$(command -v apt)" ]; then
    DEBIAN_FRONTEND=noninteractive apt update
  elif [ "$(command -v apt-get)" ]; then
    DEBIAN_FRONTEND=noninteractive apt-get update
  fi

  # Installing packages
  for package in "$@" ; do
    if [ "$(command -v apt)" ]; then
      DEBIAN_FRONTEND=noninteractive apt install -y "$package"
    elif [ "$(command -v apt-get)" ]; then
      DEBIAN_FRONTEND=noninteractive apt-get install -y "$package"
    fi
  done
}