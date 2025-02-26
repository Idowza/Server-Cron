#!/bin/bash

LOG_FILE="/home/steven/bin/log/update_$(date +%F+%T).txt"

# Redirect stdout and stderr to the log file, and append if the file exists
exec &>> "${LOG_FILE}"

apt-get update -y
apt-get upgrade -y
flatpak update -y
apt-get autoremove -y
apt-get autoclean -y
apt-get autopurge -y
apt-get install -f -y
dpkg --configure -a

sudo PIHOLE_SKIP_OS_CHECK=true pihole -up
sudo pihole -g
