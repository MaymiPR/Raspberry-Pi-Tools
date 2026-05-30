#!/bin/bash

echo "============================="
echo "    PI TOOLS INSTALLER       "
echo "============================="
echo ""

# Config
GITHUB_USER="MaymiPR"
GITHUB_REPO="Raspberry-Pi-Tools"
BRANCH="main"
INSTALL_DIR="$HOME/Documents/Raspberry Pi Tools"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$BRANCH"

TOOLS=(
    "Pi Updater.sh"
    "Pi System Info.sh"
    "Pi Cleaner.sh"
    "PI Docker Status.sh"
    "PI Docker Cleanup.sh"
    "Pi Docker Restart.sh"
    "Pi Port Scanner.sh"
)

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
        ((SUCCESS++))
    else
        echo "FAILED (HTTP $HTTP_CODE)"
        rm -f "$INSTALL_DIR/$tool"
        ((FAILED++))
    fi
done

echo ""
echo "--- Summary ---"
echo "  Installed:  $SUCCESS tools"
echo "  Failed:     $FAILED tools"
echo "  Location:   $INSTALL_DIR"

echo ""
echo "--- Installed Tools ---"
ls -lh "$INSTALL_DIR" | awk 'NR>1 {print "  "$NF"\t("$5")"}'

echo ""
echo "You can now run any tool with:"
echo "  bash \"$INSTALL_DIR/sysinfo.sh\""
echo "============================="
