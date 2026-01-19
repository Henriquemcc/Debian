#!/bin/bash

# Getting PID
read -p "Process PID: " -r process_pid

# Getting process file
directory="/proc/${process_pid}"

# Waiting until process finishes
while [ -d "$directory" ]; do
  echo "Process is running"
  sleep 10s
done

#Shutting down
echo "Shutting down"

while true ; do
  shutdown -h now
done
