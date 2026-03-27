#!/bin/bash

# Importing functions run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Checking if secure boot is enabled
if [ "$(mokutil --sb-state)" != "SecureBoot enabled" ]; then
  exit 0
fi

# Running as root
run_as_root

# Installing requirements
apt_install openssl mokutil

# Creating signed modules folder
path_folder_signed_modules="/root/signed-modules"
mkdir -p "$path_folder_signed_modules"

# Creating configuration file
path_configuration_file="$path_folder_signed_modules/configuration_file.config"

# Setting key files path
path_private_key="$path_folder_signed_modules/private_key.priv"
path_public_key="$path_folder_signed_modules/public_key.der"

# Exiting if files exist
if [[ -f "$path_private_key" && -f "$path_public_key" ]]; then
  echo "File already exist"
  exit 0
fi

{
  echo "[ req ]"
  echo "default_bits = 4096"
  echo "distinguished_name = req_distinguished_name"
  echo "prompt = no"
  echo "string_mask = utf8only"
  echo "x509_extensions = myexts"
  echo
  echo "[ req_distinguished_name ]"
  echo "O = Organization"
  echo "CN = Organization signing key"
  echo "emailAddress = E-mail address"
  echo
  echo "[ myexts ]"
  echo "basicConstraints=critical,CA:FALSE"
  echo "keyUsage=digitalSignature"
  echo "subjectKeyIdentifier=hash"
  echo "authorityKeyIdentifier=keyid"
} >"$path_configuration_file"

# Creating pair of keys
openssl req -x509 -new -nodes -utf8 -sha256 -days 36500 -batch -config "$path_configuration_file" -outform DER -out "$path_public_key" -keyout "$path_private_key"

# Adding keys to UEFI
mokutil --import "$path_public_key"
