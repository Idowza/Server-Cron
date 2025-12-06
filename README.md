# Server Cron Update Script

A robust Bash script designed for automated maintenance of Debian/Ubuntu-based homelab servers. It handles system updates, package cleaning, and Pi-hole updates, with detailed logging and automatic log rotation.

## Features

- **System Updates**: Runs `apt-get update` and `apt-get upgrade`.
- **Flatpak Support**: Updates installed Flatpak applications.
- **Cleanup**: Performs `autoremove`, `autoclean`, and fixes broken installs.
- **Pi-hole Updates**: Updates Pi-hole core and Gravity (adlists), skipping OS checks if necessary.
- **Logging**:
  - Logs all output to `/home/steven/bin/log/`.
  - Timestamps every execution.
  - **Auto-rotation**: Automatically deletes logs older than 30 days to save space.

## Prerequisites

- A Debian/Ubuntu-based system.
- Root privileges (the script must be run as root).
- [Pi-hole](https://pi-hole.net/) installed (optional, but the script includes commands for it).
- [Flatpak](https://flatpak.org/) installed (optional, but the script includes commands for it).

## Installation & Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Idowza/Server-Cron.git
   cd Server-Cron
   ```

2. **Make the script executable:**
   ```bash
   chmod +x cronupdate.sh
   ```

3. **Verify the Log Path:**
   Open `cronupdate.sh` and ensure the `LOG_DIR` variable points to a valid directory for your user (default is `/home/steven/bin/log`). You may need to change `/home/steven` to your actual home directory.

4. **Set up the Cron Job:**
   Open the root crontab:
   ```bash
   sudo crontab -e
   ```

   Add the following line to run the script daily at 3:00 AM (adjust the path to where you saved the script):
   ```cron
   0 3 * * * /path/to/Server-Cron/cronupdate.sh
   ```

## Logs

Logs are generated in the configured log directory with the format `update_YYYY-MM-DD_HH-MM-SS.txt`.
You can check the latest log to verify the update status:

```bash
tail -f /home/steven/bin/log/update_*.txt
```
