#!/bin/bash

# Setup script for GitHub Codespaces
# This script installs Node-RED and required dependencies

set -e

echo "🚀 Setting up Email AI Assistant environment..."

# Install Node-RED globally
echo "📦 Installing Node-RED..."
npm install -g --unsafe-perm node-red

# Create Node-RED directory in workspace
echo "📁 Creating Node-RED directory..."
mkdir -p "${NODE_RED_HOME:-$HOME/.node-red}"

# Install required Node-RED nodes
echo "📦 Installing required Node-RED nodes..."
cd "${NODE_RED_HOME:-$HOME/.node-red}"
npm install node-red-node-email
npm install node-red-contrib-http-request

# Install the project package if available
if [ -f "${containerWorkspaceFolder}/package.json" ]; then
    echo "📦 Installing project dependencies..."
    npm install node-red-contrib-email-analysis-deepseek || echo "⚠️  Package installation skipped (may need manual install)"
fi

# Create .env file from example if it doesn't exist
if [ ! -f "${containerWorkspaceFolder}/.env" ]; then
    echo "📄 Creating .env file from .env.example..."
    if [ -f "${containerWorkspaceFolder}/.env.example" ]; then
        cp "${containerWorkspaceFolder}/.env.example" "${containerWorkspaceFolder}/.env"
        echo "✅ .env file created. Please edit it and add your API keys."
    else
        echo "⚠️  .env.example not found. Creating basic .env file..."
        cat > "${containerWorkspaceFolder}/.env" << 'EOF'
# DeepSeek API Configuration
# Get your API key from: https://www.deepseek.com/
DEEPSEEK_API_KEY=your_deepseek_api_key_here

# Gmail OAuth2 Token - Required for email monitoring
# Get your OAuth2 token from Google Cloud Console
GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here
EOF
    fi
else
    echo "ℹ️  .env file already exists"
fi

# Make start scripts executable
if [ -f "${containerWorkspaceFolder}/start-nodered.sh" ]; then
    chmod +x "${containerWorkspaceFolder}/start-nodered.sh"
    echo "✅ Made start-nodered.sh executable"
fi

if [ -f "${containerWorkspaceFolder}/.devcontainer/start-nodered-background.sh" ]; then
    chmod +x "${containerWorkspaceFolder}/.devcontainer/start-nodered-background.sh"
    echo "✅ Made start-nodered-background.sh executable"
fi

if [ -f "${containerWorkspaceFolder}/.devcontainer/stop-nodered.sh" ]; then
    chmod +x "${containerWorkspaceFolder}/.devcontainer/stop-nodered.sh"
    echo "✅ Made stop-nodered.sh executable"
fi

# Setup bashrc for auto-start
if [ -f "${containerWorkspaceFolder}/.devcontainer/.bashrc" ]; then
    # Append to user's .bashrc if not already there
    if ! grep -q "Auto-start Node-RED" ~/.bashrc 2>/dev/null; then
        echo "" >> ~/.bashrc
        echo "# Auto-start Node-RED (from devcontainer)" >> ~/.bashrc
        cat "${containerWorkspaceFolder}/.devcontainer/.bashrc" >> ~/.bashrc
        echo "✅ Configured bashrc for auto-start"
    fi
fi

echo "✅ Setup complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Next Steps for GitHub Codespaces:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  Configure your API keys in .env file:"
echo "   - Edit .env file and add your DeepSeek API key:"
echo "     DEEPSEEK_API_KEY=sk-your-actual-api-key-here"
echo "   - Add your Gmail OAuth2 token:"
echo "     GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here"
echo ""
echo "2️⃣  Start Node-RED:"
echo "   - Node-RED will auto-start in background when Codespace starts"
echo "   - Or manually run: ./start-nodered.sh"
echo "   - Or run in background: bash .devcontainer/start-nodered-background.sh"
echo "   - To stop: bash .devcontainer/stop-nodered.sh"
echo ""
echo "3️⃣  Access Node-RED:"
echo "   - The port 1880 will be automatically forwarded"
echo "   - Click on the 'Ports' tab in VS Code"
echo "   - Click on the Node-RED port (1880) to open in browser"
echo "   - Or access: http://localhost:1880"
echo ""
echo "4️⃣  Import flow files:"
echo "   - In Node-RED editor, click Menu (☰) → Import"
echo "   - Select flows/flow-english.json or flows/flow-chinese.json"
echo "   - Click Deploy"
echo ""
echo "5️⃣  Access the web interface:"
echo "   - After deploying, visit: http://localhost:1880/notifications"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📚 For detailed instructions, see SETUP.md"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

