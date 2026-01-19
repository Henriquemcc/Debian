#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_21_Headless.bash

# Installing Java 21 JRE
apt install -y openjdk-21-jre

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 21"
  echo "GenericName=Java 21"
  echo "Icon=java-21-openjdk"
  echo "Exec=java21 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 21; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java21.desktop"
