#!/bin/bash

# Background startup script for Node-RED in Codespaces
# This script starts Node-RED in the background and keeps it running

# Don't exit on error, we want to log errors
set +e

echo "🚀 Starting Node-RED in background..."

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Try multiple methods to get workspace directory
if [ -n "$containerWorkspaceFolder" ]; then
    WORKSPACE_DIR="$containerWorkspaceFolder"
elif [ -n "$CODESPACE_VSCODE_FOLDER" ]; then
    WORKSPACE_DIR="$CODESPACE_VSCODE_FOLDER"
elif [ -d "/workspaces" ]; then
    # Find the workspace directory
    WORKSPACE_DIR=$(find /workspaces -maxdepth 1 -type d ! -path /workspaces | head -1)
else
    WORKSPACE_DIR=$(dirname "$SCRIPT_DIR")
fi

echo "📁 Workspace directory: ${WORKSPACE_DIR}"

# Verify node-red is installed
if ! command -v node-red &> /dev/null; then
    echo "❌ Node-RED is not installed. Please wait for setup to complete."
    echo "   You can manually start Node-RED later with: ./start-nodered.sh"
    exit 0  # Don't fail, just exit gracefully
fi

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
cd "${WORKSPACE_DIR}" || {
    echo "❌ Failed to change to workspace directory"
    exit 1
}

# Ensure NODE_RED_HOME is set
export NODE_RED_HOME="${NODE_RED_HOME:-${WORKSPACE_DIR}/.node-red}"

# Start Node-RED in background with proper environment
nohup bash -c "cd '${WORKSPACE_DIR}' && export NODE_RED_HOME='${NODE_RED_HOME}' && $(cat "${WORKSPACE_DIR}/.env" 2>/dev/null | grep -v '^#' | sed 's/^/export /') && node-red" > "${WORKSPACE_DIR}/.node-red/logs/nodered.log" 2>&1 &

# Save PID
NODERED_PID=$!
echo $NODERED_PID > "${WORKSPACE_DIR}/.node-red/nodered.pid"

echo "✅ Node-RED starting in background (PID: $NODERED_PID)"
echo "📝 Logs are available at: ${WORKSPACE_DIR}/.node-red/logs/nodered.log"
echo "🛑 To stop Node-RED, run: bash .devcontainer/stop-nodered.sh"

# Wait a bit longer for Node-RED to start
echo "⏳ Waiting for Node-RED to start..."
sleep 5

# Check if it's running
if pgrep -f "node-red" > /dev/null; then
    echo "✅ Node-RED is running successfully"
    echo "🌐 Access Node-RED at: http://localhost:1880"
    
    # Show last few lines of log
    echo ""
    echo "📋 Recent log output:"
    tail -5 "${WORKSPACE_DIR}/.node-red/logs/nodered.log" 2>/dev/null || echo "   (Log file not yet created)"
else
    echo "❌ Node-RED failed to start"
    echo "📋 Check logs: ${WORKSPACE_DIR}/.node-red/logs/nodered.log"
    echo ""
    echo "Last 20 lines of log:"
    tail -20 "${WORKSPACE_DIR}/.node-red/logs/nodered.log" 2>/dev/null || echo "   (No log file found)"
    echo ""
    echo "💡 You can manually start Node-RED with: ./start-nodered.sh"
    exit 0  # Don't fail the container startup
fi

