#!/bin/bash

url_technic_launcher_file="https://launcher.technicpack.net/launcher4/1004/TechnicLauncher.jar"
url_technic_launcher_picture="https://i.imgur.com/MDyTikO.png"
path_installation_directory="${HOME}/.bin"
path_applications_folder="${HOME}/.local/share/applications"
path_icons_directory="${HOME}/.local/share/icons/hicolor/303x303/apps"

# Installing requirements
bash ./Install-Java_21_Gui.bash
bash ./Install-Curl.bash
bash ./Install-Xrandr.bash

# Downloading jar file
mkdir -p "$path_installation_directory"
path_technic_launcher_jar="${path_installation_directory}/TechnicLauncher.jar"
curl -L "$url_technic_launcher_file" > "$path_technic_launcher_jar"

# Creating icon directory if it does not exist
mkdir -p "$path_icons_directory"

# Downloading icon file
path_technic_launcher_icon="${path_icons_directory}/technic_launcher.png"
curl -L "$url_technic_launcher_picture" > "$path_technic_launcher_icon"

# Creating shortcut
path_technic_launcher_shortcut="${path_applications_folder}/TechnicLauncher.desktop"
{
    echo "[Desktop Entry]"
    echo "Version=1.5"
    echo "Name=TechnicLauncher"
    echo "Type=Application"
    echo "Exec=java21 -jar $path_technic_launcher_jar"
    echo "Icon=$path_technic_launcher_icon"
    echo "StartupNotify=true"
    echo "Categories=Game;"
  } > "$path_technic_launcher_shortcut"
