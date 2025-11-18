#!/bin/bash

# Quick check script for Node-RED status

echo "🔍 Checking Node-RED status..."
echo ""

# Check if running
if pgrep -f "node-red" > /dev/null; then
    echo "✅ Node-RED is RUNNING"
    echo ""
    echo "Process info:"
    ps aux | grep "[n]ode-red" | head -1
    echo ""
    
    # Check if port is listening
    if lsof -i :1880 > /dev/null 2>&1; then
        echo "✅ Port 1880 is listening"
    else
        echo "⚠️  Port 1880 is not listening (may still be starting)"
    fi
else
    echo "❌ Node-RED is NOT running"
    echo ""
    echo "To start Node-RED:"
    echo "  ./start-nodered.sh"
    echo "  or"
    echo "  bash .devcontainer/start-nodered-background.sh"
fi

echo ""
echo "📋 Logs location:"
echo "  .node-red/logs/nodered.log"
echo ""
echo "📋 View logs:"
echo "  tail -f .node-red/logs/nodered.log"

