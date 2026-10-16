#!/bin/bash
#
# Pi Tools Installer
# Downloads every Raspberry Pi Tools script into a local folder and makes
# them executable.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/MaymiPR/Raspberry-Pi-Tools/main/Pi-Tools-Installer.sh | bash
#
# Override the install location with INSTALL_DIR:
#   curl -fsSL .../Pi-Tools-Installer.sh | INSTALL_DIR="$HOME/pi-tools" bash

echo "============================="
echo "    PI TOOLS INSTALLER       "
echo "============================="
echo ""

# Config
GITHUB_USER="MaymiPR"
GITHUB_REPO="Raspberry-Pi-Tools"
BRANCH="main"
INSTALL_DIR="${INSTALL_DIR:-$HOME/Documents/Pi-Tools}"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$BRANCH"

TOOLS=(
    "Pi-Updater.sh"
    "Pi-System-Info.sh"
    "Pi-Cleaner.sh"
    "Pi-Docker-Status.sh"
    "Pi-Docker-Cleanup.sh"
    "Pi-Docker-Restart.sh"
    "Pi-Port-Scanner.sh"
)

if ! command -v curl &>/dev/null; then
    echo "curl is required. Install it with: sudo apt install curl"
    exit 1
fi

# Create folder if it doesn't exist
echo "Setting up folder at: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
echo ""

# Download each tool
SUCCESS=0
FAILED=0

for tool in "${TOOLS[@]}"; do
    echo -n "Downloading $tool... "
    HTTP_CODE=$(curl -s -o "$INSTALL_DIR/$tool" -w "%{http_code}" "$BASE_URL/$tool")
    if [ "$HTTP_CODE" = "200" ]; then
        chmod +x "$INSTALL_DIR/$tool"
        echo "OK"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "FAILED (HTTP $HTTP_CODE)"
        rm -f "$INSTALL_DIR/$tool"
        FAILED=$((FAILED + 1))
    fi
done

echo ""
echo "--- Summary ---"
echo "  Installed:  $SUCCESS tools"
echo "  Failed:     $FAILED tools"
echo "  Location:   $INSTALL_DIR"

echo ""
echo "--- Installed Tools ---"
for tool in "${TOOLS[@]}"; do
    if [ -f "$INSTALL_DIR/$tool" ]; then
        printf "  %-24s (%s)\n" "$tool" "$(du -h "$INSTALL_DIR/$tool" | cut -f1)"
    fi
done

echo ""
echo "You can now run any tool with, for example:"
echo "  \"$INSTALL_DIR/Pi-System-Info.sh\""
echo "============================="

[ "$FAILED" -eq 0 ]
