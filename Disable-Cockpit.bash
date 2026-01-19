#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Disabling Cockpit
systemctl disable --now cockpit.socket
systemctl disable --now cockpit.service