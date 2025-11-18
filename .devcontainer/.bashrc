# Auto-start Node-RED when terminal opens (if not already running)
# This file is sourced when a new bash shell starts

# Only run in Codespaces environment
if [ -n "$CODESPACE_NAME" ] || [ -n "$CODESPACES" ]; then
    # Check if Node-RED is already running
    if ! pgrep -f "node-red" > /dev/null 2>&1; then
        # Check if node-red is installed
        if command -v node-red &> /dev/null; then
            # Get workspace directory
            if [ -n "$containerWorkspaceFolder" ]; then
                WORKSPACE_DIR="$containerWorkspaceFolder"
            elif [ -d "/workspaces" ]; then
                WORKSPACE_DIR=$(find /workspaces -maxdepth 1 -type d ! -path /workspaces | head -1)
            else
                WORKSPACE_DIR="$HOME"
            fi
            
            # Only auto-start if .env exists (user has configured)
            if [ -f "${WORKSPACE_DIR}/.env" ]; then
                echo "🚀 Auto-starting Node-RED in background..."
                bash "${WORKSPACE_DIR}/.devcontainer/start-nodered-background.sh" > /dev/null 2>&1 &
                sleep 2
                if pgrep -f "node-red" > /dev/null 2>&1; then
                    echo "✅ Node-RED started automatically"
                fi
            fi
        fi
    fi
fi

