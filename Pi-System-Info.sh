#!/bin/bash
#
# Pi System Info
# Prints a one-screen snapshot of temperature, CPU, RAM, disk, uptime,
# network addresses, hostname, and OS.

echo "============================="
echo "       PI SYSTEM INFO        "
echo "============================="
echo ""

# CPU Temperature
temp=$(vcgencmd measure_temp 2>/dev/null | cut -d= -f2)
echo "CPU Temp:     ${temp:-N/A}"

# CPU Usage
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage:    ${cpu}%"

# RAM
ram=$(free -h | awk '/^Mem:/ {print $3 " / " $2}')
echo "RAM Usage:    $ram"

# Disk
disk=$(df -h / | awk 'NR==2 {print $3 " / " $2 " ("$5" used)"}')
echo "Disk Usage:   $disk"

# Uptime
uptime_str=$(uptime -p)
echo "Uptime:       $uptime_str"

# LAN (Ethernet)
lan=$(ip addr show eth0 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1)
echo "LAN IP:       ${lan:-Not connected}"

# WLAN (WiFi)
wlan=$(ip addr show wlan0 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1)
echo "WLAN IP:      ${wlan:-Not connected}"

# Public IP
pub_ip=$(curl -s --max-time 5 ifconfig.me)
echo "Public IP:    ${pub_ip:-Unavailable}"

# Hostname
echo "Hostname:     $(hostname)"

# OS
os=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
echo "OS:           $os"

echo ""
echo "============================="
