#!/bin/bash

# Start Node-RED with environment variables from .env file
# This script loads .env file and starts Node-RED

set -e

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load .env file if it exists
if [ -f "${SCRIPT_DIR}/.env" ]; then
    echo "📄 Loading environment variables from .env file..."
    export $(cat "${SCRIPT_DIR}/.env" | grep -v '^#' | xargs)
    echo "✅ Environment variables loaded"
else
    echo "⚠️  Warning: .env file not found. Please create one from .env.example"
    echo "   Copy .env.example to .env and configure your API keys"
fi

# Check if required environment variables are set
if [ -z "$DEEPSEEK_API_KEY" ]; then
    echo "⚠️  Warning: DEEPSEEK_API_KEY is not set"
    echo "   Please set it in .env file or as an environment variable"
fi

if [ -z "$GMAIL_OAUTH_TOKEN" ]; then
    echo "⚠️  Warning: GMAIL_OAUTH_TOKEN is not set"
    echo "   Please set it in .env file or as an environment variable"
    echo "   Email monitoring will not work without this token"
fi

# Start Node-RED
echo "🚀 Starting Node-RED..."
node-red

