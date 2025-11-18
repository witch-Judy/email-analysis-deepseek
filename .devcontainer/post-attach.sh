#!/bin/bash

# This script runs after VS Code attaches to the container
# It's a more reliable way to auto-start services

echo "🔗 VS Code attached to container"

# Wait a moment for everything to settle
sleep 3

# Get workspace directory
if [ -n "$containerWorkspaceFolder" ]; then
    WORKSPACE_DIR="$containerWorkspaceFolder"
elif [ -d "/workspaces" ]; then
    WORKSPACE_DIR=$(find /workspaces -maxdepth 1 -type d ! -path /workspaces | head -1)
else
    WORKSPACE_DIR="$HOME"
fi

# Check if Node-RED is already running
if pgrep -f "node-red" > /dev/null 2>&1; then
    echo "✅ Node-RED is already running"
    exit 0
fi

# Check if node-red is installed
if ! command -v node-red &> /dev/null; then
    echo "⏳ Node-RED not yet installed, will start after setup completes"
    exit 0
fi

# Check if .env exists (user has configured)
if [ ! -f "${WORKSPACE_DIR}/.env" ]; then
    echo "ℹ️  .env file not found, skipping auto-start"
    echo "   Create .env file and Node-RED will auto-start on next terminal open"
    exit 0
fi

# Start Node-RED
echo "🚀 Auto-starting Node-RED..."
bash "${WORKSPACE_DIR}/.devcontainer/start-nodered-background.sh"

