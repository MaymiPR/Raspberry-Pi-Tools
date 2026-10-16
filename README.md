<div align="center">

# 🍓 Raspberry Pi Tools

**Simple, single-file Bash scripts for everyday Raspberry Pi maintenance.**

Update, clean, monitor, and manage Docker on your Pi with a single command each.

[![ShellCheck](https://github.com/MaymiPR/Raspberry-Pi-Tools/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/MaymiPR/Raspberry-Pi-Tools/actions/workflows/shellcheck.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi%20OS-C51A4A?logo=raspberrypi&logoColor=white)
![Shell](https://img.shields.io/badge/shell-bash-4EAA25?logo=gnubash&logoColor=white)

</div>

---

## Contents

- [Quick start](#quick-start)
- [Tools](#tools)
- [Usage](#usage)
- [Requirements](#requirements)
- [Safety notes](#safety-notes)
- [Contributing](#contributing)
- [License](#license)

## Quick start

Install every tool into `~/Documents/Pi-Tools`:

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Tools-Installer.sh | bash
```

Then run any of them:

```bash
~/Documents/Pi-Tools/Pi-System-Info.sh
```

To install somewhere else, set `INSTALL_DIR`:

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Tools-Installer.sh | INSTALL_DIR="$HOME/pi-tools" bash
```

## Tools

| Tool | What it does | Needs `sudo` |
| --- | --- | :---: |
| [**Pi Updater**](Pi-Updater.sh) | Updates packages (`full-upgrade`), the bootloader EEPROM, and cleans up afterwards, then offers to reboot. | ✅ |
| [**Pi System Info**](Pi-System-Info.sh) | One-screen snapshot: CPU temperature and usage, RAM, disk, uptime, LAN/Wi-Fi/public IP, hostname, and OS. | — |
| [**Pi Port Scanner**](Pi-Port-Scanner.sh) | Lists listening ports with protocol, process, and service name; shows active connections and a summary. | ✅ |
| [**Pi Cleaner**](Pi-Cleaner.sh) | Removes unused packages, the apt cache, logs older than 7 days, and old temp files, then reports space freed. | ✅ |
| [**Pi Docker Status**](Pi-Docker-Status.sh) | Shows running and stopped containers and installed images. | — |
| [**Pi Docker Cleanup**](Pi-Docker-Cleanup.sh) | Removes stopped containers, unused images, and unused volumes. | — |
| [**Pi Docker Restart**](Pi-Docker-Restart.sh) | Lists containers and restarts the one you pick. | — |
| [**Pi Tools Installer**](Pi-Tools-Installer.sh) | Downloads all of the tools above into one folder and makes them executable. | — |

> Docker tools assume your user is in the `docker` group. If not, run them with `sudo`.

## Usage

Each tool can also be run directly without installing anything:

<details>
<summary><b>Pi Updater</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Updater.sh | bash
```
</details>

<details>
<summary><b>Pi System Info</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-System-Info.sh | bash
```

```
=============================
       PI SYSTEM INFO
=============================

CPU Temp:     48.2'C
CPU Usage:    3.1%
RAM Usage:    612Mi / 3.7Gi
Disk Usage:   9.8G / 29G (36% used)
Uptime:       up 3 days, 4 hours
LAN IP:       192.168.1.20
WLAN IP:      Not connected
Public IP:    203.0.113.42
Hostname:     raspberrypi
OS:           Debian GNU/Linux 12 (bookworm)

=============================
```
</details>

<details>
<summary><b>Pi Port Scanner</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Port-Scanner.sh | bash
```
</details>

<details>
<summary><b>Pi Cleaner</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Cleaner.sh | bash
```
</details>

<details>
<summary><b>Pi Docker Status</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Docker-Status.sh | bash
```
</details>

<details>
<summary><b>Pi Docker Cleanup</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Docker-Cleanup.sh | bash
```
</details>

<details>
<summary><b>Pi Docker Restart</b></summary>

```bash
curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Docker-Restart.sh | bash
```
</details>

## Requirements

- A Raspberry Pi running **Raspberry Pi OS** (or another Debian-based distro)
- `bash` and `curl` (preinstalled on Raspberry Pi OS)
- `sudo` access for the tools marked above
- [Docker](https://docs.docker.com/engine/install/debian/) for the Docker tools

Tested on Raspberry Pi OS Bookworm. `rpi-eeprom-update` (used by Pi Updater) applies to Raspberry Pi 4, 400, 5, and newer.

## Safety notes

- **Read before you pipe.** Piping a script from the internet into `bash` runs it with your permissions. Every script here is short and readable, so check it on GitHub first or download it and inspect it:
  ```bash
  curl -fsSLO https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Cleaner.sh
  less Pi-Cleaner.sh
  bash Pi-Cleaner.sh
  ```
- **Pi Docker Cleanup** runs `docker image prune -a` and `docker volume prune`. That removes **every** image not used by a container and every unused volume, including any data stored in those volumes.
- **Pi Updater** uses `apt full-upgrade`, which may install or remove packages to resolve dependencies.

## Contributing

Issues and pull requests are welcome. Please keep new tools:

- self-contained in a single `Pi-<Name>.sh` file
- in the same style as the existing scripts (banner, numbered steps)
- passing [ShellCheck](https://www.shellcheck.net/), which runs automatically on every push and pull request

When you add a tool, also add it to the `TOOLS` list in [`Pi-Tools-Installer.sh`](Pi-Tools-Installer.sh) and to the table above.

## License

Released under the [MIT License](LICENSE).
