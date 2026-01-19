#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_8_Headless.bash

# Checking if Java compiler 8 is installed
if [ "$(command -v javac8)" ]; then
    exit 0
fi

# Installing Java 8 JDK
apt install -y openjdk-8-jdk

# Creating command javac8
ln --symbolic "/usr/lib/jvm/java-1.8.0/bin/javac" "/bin/javac8"