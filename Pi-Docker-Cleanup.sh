#!/bin/bash

echo "============================="
echo "     PI DOCKER CLEANUP       "
echo "============================="
echo ""

if ! command -v docker &>/dev/null; then
    echo "Docker is not installed."
    exit 1
fi

echo "[1/3] Removing stopped containers..."
docker container prune -f

echo ""
echo "[2/3] Removing unused images..."
docker image prune -a -f

echo ""
echo "[3/3] Removing unused volumes..."
docker volume prune -f

echo ""
echo "Done! Docker space usage:"
docker system df

echo ""
echo "============================="
