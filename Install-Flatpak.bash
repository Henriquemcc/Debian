#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Flatpak
apt install flatpak --assume-yes

# Installing the Flatpak plugin
apt install gnome-software-plugin-flatpak --assume-yes

# Adding FlatHub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo