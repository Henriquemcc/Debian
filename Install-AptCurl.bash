#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running this script as root
run_as_root

source_file_name="apt-curl.bash"
source_directory="$(dirname "$0")"
source_file_path="${source_directory}/Resources/Install-Remote-Deb-File/${source_file_name}"

destination_file_name="apt-curl"
destination_path="/usr/bin/${destination_file_name}"

# Copying script
cp "$source_file_path" "$destination_path"

# Changing installed script permission
chmod +x "$destination_path"