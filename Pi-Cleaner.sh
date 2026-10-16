#!/bin/bash
#
# Pi Cleaner
# Frees disk space by removing unused packages, the apt cache, journal logs
# older than 7 days, and temp files older than 1 day.

echo "============================="
echo "         PI CLEANER          "
echo "============================="
echo ""

used_before=$(df -k / | awk 'NR==2 {print $3}')

echo "[1/4] Removing unused packages..."
sudo apt autoremove -y

echo ""
echo "[2/4] Clearing apt cache..."
sudo apt clean

echo ""
echo "[3/4] Clearing old logs..."
sudo journalctl --vacuum-time=7d

echo ""
echo "[4/4] Clearing temp files older than 1 day..."
# Only old files are removed so running programs keep their sockets and locks.
sudo find /tmp -mindepth 1 -mtime +1 -delete 2>/dev/null

used_after=$(df -k / | awk 'NR==2 {print $3}')
freed_kb=$(( used_before - used_after ))
[ "$freed_kb" -lt 0 ] && freed_kb=0

echo ""
echo "Done!"
echo "  Space freed:  $(( freed_kb / 1024 )) MB"
df -h / | awk 'NR==2 {print "  Disk usage:   "$3" / "$2" ("$5" used)"}'
echo "============================="
