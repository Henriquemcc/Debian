#!/bin/bash

# Checking if Java 17 is installed
if [ "$(command -v java17)" ]; then
    exit 0
fi

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java 17 JRE
apt install --assumeyes openjdk-17-jre-headless

# Creating command java17
ln --symbolic "/usr/lib/jvm/java-17/bin/java" "/bin/java17"