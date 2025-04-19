#!/bin/bash

os_release_file="/etc/os-release"

# Get the version of the operating system
function get_os_version() {
  if [ -f $os_release_file ]; then
      grep "^VERSION_ID=" /etc/os-release | sed 's/VERSION_ID=//; s/"//g' | awk -F'.' '{print $1}'
  else
    echo "Unknown distribution or version."
    exit 1
  fi
}

# Get the type of the operating system
# Common return values are "rhel", "centos", "fedora"
function get_os_type() {
  if [ -f $os_release_file ]; then
      grep "^ID=" /etc/os-release | sed 's/ID=//; s/"//g'
  else
    echo "Unknown distribution or version."
    exit 1
  fi
}