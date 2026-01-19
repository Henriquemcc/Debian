#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_11_Headless.bash

# Installing Java 11 JRE
apt install --assumeyes openjdk-11-jre

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 11"
  echo "GenericName=Java 11"
  echo "Icon=java-11-openjdk"
  echo "Exec=java11 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 11; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java11.desktop"
