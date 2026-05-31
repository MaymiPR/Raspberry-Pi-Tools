#!/bin/bash

echo "============================="
echo "    PI TOOLS INSTALLER       "
echo "============================="
echo ""

# Config
GITHUB_USER="MaymiPR"
GITHUB_REPO="Raspberry-Pi-Tools"
BRANCH="refs/heads/main"
INSTALL_DIR="$HOME/Documents/Pi-Tools"
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

# Create folder if it doesn't exist
echo "Setting up folder at: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
echo ""

# Download each tool
SUCCESS=0
FAILED=0

for tool in "${TOOLS[@]}"; do
    clean_name=$(echo "$tool" | sed 's/%20/ /g')
    echo -n "Downloading $clean_name... "
    HTTP_CODE=$(curl -s -o "$INSTALL_DIR/$clean_name" -w "%{http_code}" "$BASE_URL/$tool")
    if [ "$HTTP_CODE" = "200" ]; then
        chmod +x "$INSTALL_DIR/$clean_name"
        echo "OK"
        ((SUCCESS++))
    else
        echo "FAILED (HTTP $HTTP_CODE)"
        rm -f "$INSTALL_DIR/$clean_name"
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
