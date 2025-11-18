#!/bin/bash

# Background startup script for Node-RED in Codespaces
# This script starts Node-RED in the background and keeps it running

set -e

echo "🚀 Starting Node-RED in background..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKSPACE_DIR="${containerWorkspaceFolder:-$(dirname "$SCRIPT_DIR")}"

# Load .env file if it exists
if [ -f "${WORKSPACE_DIR}/.env" ]; then
    echo "📄 Loading environment variables from .env file..."
    export $(cat "${WORKSPACE_DIR}/.env" | grep -v '^#' | xargs)
    echo "✅ Environment variables loaded"
else
    echo "⚠️  Warning: .env file not found at ${WORKSPACE_DIR}/.env"
    echo "   Node-RED will start but may not work correctly without API keys"
fi

# Check if Node-RED is already running
if pgrep -f "node-red" > /dev/null; then
    echo "ℹ️  Node-RED is already running"
    exit 0
fi

# Create log directory
mkdir -p "${WORKSPACE_DIR}/.node-red/logs"

# Start Node-RED in background
cd "${WORKSPACE_DIR}"
nohup node-red > "${WORKSPACE_DIR}/.node-red/logs/nodered.log" 2>&1 &

# Save PID
echo $! > "${WORKSPACE_DIR}/.node-red/nodered.pid"

echo "✅ Node-RED started in background (PID: $(cat ${WORKSPACE_DIR}/.node-red/nodered.pid))"
echo "📝 Logs are available at: ${WORKSPACE_DIR}/.node-red/logs/nodered.log"
echo "🛑 To stop Node-RED, run: pkill -f node-red"

# Wait a moment for Node-RED to start
sleep 3

# Check if it's running
if pgrep -f "node-red" > /dev/null; then
    echo "✅ Node-RED is running successfully"
    echo "🌐 Access Node-RED at: http://localhost:1880"
else
    echo "❌ Node-RED failed to start. Check logs: ${WORKSPACE_DIR}/.node-red/logs/nodered.log"
    exit 1
fi

