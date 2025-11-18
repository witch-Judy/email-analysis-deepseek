#!/bin/bash

# Welcome message and quick start guide

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Welcome to Email AI Assistant Codespace!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Node-RED is running
if pgrep -f "node-red" > /dev/null 2>&1; then
    echo "✅ Node-RED is already running!"
    echo "🌐 Access it at: http://localhost:1880"
else
    echo "📋 Quick Start:"
    echo ""
    echo "1️⃣  Configure API keys (if not done):"
    echo "    Edit .env file and add your API keys"
    echo ""
    echo "2️⃣  Start Node-RED (one command):"
    echo "    ./start-nodered.sh"
    echo ""
    echo "   Or in background:"
    echo "    bash .devcontainer/start-nodered-background.sh"
    echo ""
    echo "3️⃣  Access Node-RED:"
    echo "    http://localhost:1880"
    echo ""
    echo "💡 Tip: Node-RED may auto-start. Check with:"
    echo "    bash .devcontainer/check-nodered.sh"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

