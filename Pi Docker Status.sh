#!/bin/bash

echo "============================="
echo "      DOCKER STATUS          "
echo "============================="
echo ""

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed."
    exit 1
fi

echo "--- Running Containers ---"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "--- Stopped Containers ---"
docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo ""
echo "--- Images ---"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

echo ""
echo "============================="
