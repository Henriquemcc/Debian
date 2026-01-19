#!/bin/bash

# Checking if Java 21 is installed
if [ "$(command -v java21)" ]; then
    exit 0
fi

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java 21 JRE
apt install -y openjdk-21-jre-headless

# Creating command java21
ln --symbolic "/usr/lib/jvm/java-21/bin/java" "/bin/java21"
