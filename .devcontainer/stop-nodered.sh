#!/bin/bash

# Stop Node-RED script

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKSPACE_DIR="${containerWorkspaceFolder:-$(dirname "$SCRIPT_DIR")}"

echo "🛑 Stopping Node-RED..."

# Try to stop using PID file
if [ -f "${WORKSPACE_DIR}/.node-red/nodered.pid" ]; then
    PID=$(cat "${WORKSPACE_DIR}/.node-red/nodered.pid")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
        echo "✅ Node-RED stopped (PID: $PID)"
        rm "${WORKSPACE_DIR}/.node-red/nodered.pid"
    else
        echo "ℹ️  Process not found, trying pkill..."
        pkill -f node-red || echo "No Node-RED process found"
    fi
else
    # Fallback to pkill
    if pkill -f node-red; then
        echo "✅ Node-RED stopped"
    else
        echo "ℹ️  No Node-RED process found"
    fi
fi

