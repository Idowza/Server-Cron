#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Set PATH to ensure commands are found in cron environment
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

LOG_DIR="/home/steven/bin/log"
# Changed time format to avoid colons in filename
LOG_FILE="$LOG_DIR/update_$(date +%F_%H-%M-%S).txt"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Redirect stdout and stderr to the log file
exec &>> "${LOG_FILE}"

echo "=========================================="
echo "Starting update at $(date)"
echo "=========================================="

echo "[+] Updating package lists..."
apt-get update -y

echo "[+] Upgrading packages..."
apt-get upgrade -y

echo "[+] Updating Flatpaks..."
flatpak update -y

echo "[+] Cleaning up..."
apt-get autoremove -y
apt-get autoclean -y
# 'autopurge' is not standard in apt-get, using --purge autoremove instead
apt-get --purge autoremove -y
apt-get install -f -y
dpkg --configure -a

echo "[+] Updating Pi-hole..."
# Removed sudo since the script checks for root at the start
PIHOLE_SKIP_OS_CHECK=true pihole -up
pihole -g

echo "[+] Cleaning old logs (older than 30 days)..."
find "$LOG_DIR" -name "update_*.txt" -type f -mtime +30 -delete

echo "=========================================="
echo "Update finished at $(date)"
echo "=========================================="
