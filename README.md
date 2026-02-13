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
wget -O setup_ssh.sh https://github.com/xpersian/ssh-key-to-pass/blob/main/root-unlocker.sh && chmod +x root-unlocker.sh && sudo ./root-unlocker.sh
```
English:

Enables Root Password Authentication on SSH-Key-only VPS instances (e.g., Infomaniak, Irancell, Hetzner). Fixes sshd_config includes & sets a secure password automatically.

Farsi:

  فعال‌سازی ورود روت با رمز عبور برای سرورهایی که فقط با SSH Key ارائه می‌شوند (مانند اینفومنیاک، ایرانسل و ...). اصلاح خودکار کانفیگ SSH و تنظیم پسورد امن.
