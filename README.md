# SSH Key to Password Enabler (Root Access)

![Shell Script](https://img.shields.io/badge/Shell_Script-Bash-4EAA25?style=flat&logo=gnu-bash&logoColor=white)

A simple bash script to enable **Root Login** with **Password Authentication** on cloud VPS instances that force SSH Key usage by default (e.g., **Infomaniak**, **Irancell**, **Hetzner**, AWS, etc.).

## 🚀 What it does
1.  Backs up your `/etc/ssh/sshd_config`.
2.  Disables limiting `Include` directives (common in Ubuntu/Cloud images).
3.  Enables `PermitRootLogin` and `PasswordAuthentication`.
4.  Generates a **random 14-character secure password** (or lets you set your own).
5.  Restarts the SSH service automatically.

## 📦 How to use (One-line command)
Run this command in your terminal. If you are not root, it will ask for sudo permission.

```bash
wget -O setup_ssh.sh [https://raw.githubusercontent.com/USERNAME/REPO/main/script.sh](https://raw.githubusercontent.com/USERNAME/REPO/main/script.sh) && chmod +x setup_ssh.sh && sudo ./setup_ssh.sh
