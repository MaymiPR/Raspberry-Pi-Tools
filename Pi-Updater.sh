#!/bin/bash
#
# Pi Updater
# Updates all packages, the bootloader EEPROM, and cleans up afterwards,
# then offers to reboot.

echo "============================="
echo "         PI UPDATER          "
echo "============================="
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
echo "Update complete!"
echo "============================="
echo ""
read -r -p "Reboot now? (y/n): " answer < /dev/tty
if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo reboot
fi
