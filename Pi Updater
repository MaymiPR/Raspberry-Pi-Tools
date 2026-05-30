#!/bin/bash
echo "Starting Pi Updater..."
echo ""

echo "[1/4] Refreshing package list..."
sudo apt update

echo ""
echo "[2/4] Upgrading packages..."
sudo apt full-upgrade -y

echo ""
echo "[3/4] Updating bootloader..."
sudo rpi-eeprom-update -a

echo ""
echo "[4/4] Cleaning up..."
sudo apt autoremove -y
sudo apt clean

echo ""
read -p "Reboot now? (y/n): " answer < /dev/tty
if [ "$answer" = "y" ]; then
    sudo reboot
fi
