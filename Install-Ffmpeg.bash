#!/bin/bash

# Importing function run_as_root and apt_install
source RunAsRoot.bash
source AptTools.bash

# Running as root
run_as_root

# Installing ffmpeg
apt_install ffmpeg