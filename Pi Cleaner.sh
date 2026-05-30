#!/bin/bash

echo "============================="
echo "       PI SYSTEM CLEANER     "
echo "============================="
echo ""

echo "[1/4] Removing unused packages..."
sudo apt autoremove -y

echo ""
echo "[2/4] Clearing apt cache..."
sudo apt clean

echo ""
echo "[3/4] Clearing old logs..."
sudo journalctl --vacuum-time=7d

echo ""
echo "[4/4] Clearing temp files..."
sudo rm -rf /tmp/*

echo ""
echo "Done! Space freed:"
df -h / | awk 'NR==2 {print "  Disk usage: "$3" / "$2" ("$5" used)"}'
echo "============================="
