#!/bin/bash

# Define the config file path
CONFIG_FILE="/etc/ssh/sshd_config"

# Check for root privileges. If not root, try to run with sudo.
if [ "$EUID" -ne 0 ]; then
  echo "[-] Root privileges required. Attempting to elevate..."
  if command -v sudo >/dev/null 2>&1; then
      exec sudo "$0" "$@"
  else
      echo "Error: This script must be run as root (or install sudo)."
      exit 1
  fi
fi

echo "--- Starting SSH Configuration Setup ---"

# 1. Backup the configuration file (in the same directory)
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
    echo "[+] Backup created successfully: $CONFIG_FILE.bak"
else
    echo "[-] Error: $CONFIG_FILE not found!"
    exit 1
fi

# 2. Modify sshd_config
# Comment out the specific Include line and append the new settings immediately after
SEARCH_PATTERN="^Include /etc/ssh/sshd_config.d/\*\.conf"
REPLACEMENT="#Include /etc/ssh/sshd_config.d/*.conf\nPermitRootLogin yes\nPasswordAuthentication yes"

if grep -q "$SEARCH_PATTERN" "$CONFIG_FILE"; then
    sed -i "s|$SEARCH_PATTERN|$REPLACEMENT|" "$CONFIG_FILE"
    echo "[+] sshd_config modified specifically as requested."
else
    # Fallback: If the specific Include line isn't found, just append settings to the end
    echo "[-] Specific 'Include' line not found. Appending settings to the end of file..."
    echo -e "\nPermitRootLogin yes\nPasswordAuthentication yes" >> "$CONFIG_FILE"
fi

# 3. Password Setup
# Generate a random 14-character secure password
RANDOM_PASS=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 14)

echo ""
echo "------------------------------------------------"
echo "Suggested Secure Root Password:"
echo -e "\033[1;32m$RANDOM_PASS\033[0m"
echo "------------------------------------------------"
read -p "Do you want to set this password for root? (y/n): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "root:$RANDOM_PASS" | chpasswd
    echo "[+] Root password updated automatically."
else
    echo "Please enter your desired root password manually:"
    passwd root
fi

# 4. Restart SSH Service
echo ""
systemctl restart ssh
echo "[+] SSH service restarted."
echo "[!] IMPORTANT: Verify access in a new terminal session before closing this one."
