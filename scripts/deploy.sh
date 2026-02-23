#!/bin/bash
# deploy.sh - 一键部署 LibreChat
# 用法: ./scripts/deploy.sh

set -e

COMPOSE_FILES="-f deploy-compose.yml -f deploy-compose.override.yml"

echo ""
echo "========================================"
echo "  LibreChat - Deploy"
echo "========================================"
echo ""

# 1. Pull latest images
echo "[1/2] Pulling latest images ..."
docker compose $COMPOSE_FILES pull
echo "[1/2] Pull completed."
echo ""

# 2. Recreate containers
echo "[2/2] Recreating containers ..."
docker compose $COMPOSE_FILES up -d --force-recreate
echo "[2/2] Done."
echo ""

echo "========================================"
echo "  Deployment complete!"
echo "========================================"
echo ""
docker compose $COMPOSE_FILES ps
