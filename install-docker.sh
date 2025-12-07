#!/bin/bash
set -e

echo "========================================================"
echo "  Backstage Docker Installer (Linux/DevContainer)"
echo "========================================================"

if [ -d "backstage-app" ]; then
    echo "[INFO] 'backstage-app' directory already exists."
    echo "[INFO] Pulling latest changes from official repo..."
    cd backstage-app
    git pull
    cd ..
else
    echo "[INFO] Cloning official Backstage repository..."
    echo "[INFO] Source: https://github.com/backstage/backstage.git"
    git clone https://github.com/backstage/backstage.git backstage-app
fi

echo "[INFO] Patching .dockerignore for source build..."
cp source.dockerignore backstage-app/.dockerignore

echo ""
echo "[INFO] Using 'packages/backend/Dockerfile' from the repo."
echo "[INFO] Starting Docker Compose..."
echo "[INFO] This will build the application from source. It may take 10-15 minutes."
echo ""

# Check for docker-compose v1 vs v2
if command -v docker-compose &> /dev/null; then
    docker-compose up -d --build
else
    docker compose up -d --build
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "[SUCCESS] Backstage is starting!"
    echo "[INFO] URL: http://localhost:7007"
    echo "[INFO] Weather Proxy: http://localhost:3001"
    echo ""
    echo "[NOTE] It may take a few minutes for the containers to fully initialize."
else
    echo "[ERROR] Docker Compose failed to start."
fi
