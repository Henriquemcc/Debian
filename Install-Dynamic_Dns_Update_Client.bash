#!/bin/bash

version="v0.0.2"
jar_url="https://github.com/Henriquemcc/Dynamic_DNS_Update_Client/releases/download/${version}/app.jar"
jar_download_destination="/usr/bin/Dynamic_Dns_Update_Client.jar"
service_name="dynamic-dns-update-client.service"
service_file_path="/etc/systemd/system/${service_name}"

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing requirements
if ! [ "$(command -v java)" ]; then
    apt install -y default-jre
fi

# Downloading JAR File
curl -L "$jar_url" -o "$jar_download_destination"

# Changing permission for the downloaded file
chmod +x "$jar_download_destination"

# Creating system service
{
  echo "[Unit]"
  echo "Description=Dynamic dns update client service"
  echo "After=network.target"
  echo "StartLimitIntervalSec=0"
  echo ""
  echo "[Service]"
  echo "Type=simple"
  echo "Restart=always"
  echo "RestartSec=1"
  echo "User=root"
  echo "ExecStart=/usr/bin/java -jar ${jar_download_destination} perform-ip-update -i"
  echo "[Install]"
  echo "WantedBy=multi-user.target"
} > "$service_file_path"

# Enabling System Service
systemctl enable --now "$service_name"

