# Setup Guide - Email AI Assistant

This guide will help you complete the full configuration and deployment of the Email AI Assistant.

## 📋 Prerequisites

### System Requirements
- Node.js 16.x or higher
- Node-RED 3.x or higher
- Stable network connection

### Required Accounts
- DeepSeek API account
- Gmail account (for email monitoring)

## 🔑 Step 1: Obtain API Keys

### 1.1 DeepSeek API Key

1. Visit [DeepSeek Official Website](https://www.deepseek.com/)
2. Register and log in to your account
3. Go to API management page
4. Create a new API key
5. Copy the generated API key (format: `sk-xxxxxxxxxxxxxxxx`)

**Important**: Please keep your API key secure and do not share it with others.

### 1.2 Gmail OAuth2 Configuration

1. Visit [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing project
3. Enable Gmail API
4. Create OAuth2 credentials
5. Configure redirect URI
6. Download credentials JSON file

## 🚀 Step 2: Install Node-RED

### 2.1 Install Node-RED

```bash
# Install Node-RED globally
npm install -g node-red

# Start Node-RED
node-red
```

### 2.2 Install Required Nodes

```bash
# Install email nodes
npm install node-red-node-email

# Install HTTP nodes (usually included)
npm install node-red-contrib-http-request
```

## 📁 Step 3: Installation and Import

### 3.1 Method 1: Install npm Package (Recommended)

```bash
cd ~/.node-red
npm install node-red-contrib-email-analysis-deepseek
```

After restarting Node-RED, find the following nodes in the "analysis" category:
- **Email Analysis DeepSeek** (English version)
- **邮件分析 DeepSeek** (Chinese version)

### 3.2 Method 2: Import Flow Files

1. Start Node-RED editor (usually http://localhost:1880)
2. Click the top-right menu → Import
3. Select one of the following files:
   - `flows/flow-english.json` (English version)
   - `flows/flow-chinese.json` (Chinese version)
4. Click Import to import the flow

### 3.3 Configure Flow Parameters

After importing, you need to configure the following key parameters:

#### Email Monitoring Configuration
- **Server**: `imap.gmail.com`
- **Port**: `993`
- **SSL**: Enabled
- **Authentication Type**: OAuth2
- **Token**: Configure OAuth2 access token

#### API Configuration
- **API Key**: Configure via environment variable `DEEPSEEK_API_KEY` (see Step 4.2)
- **API Endpoint**: `https://api.deepseek.com/v1/chat/completions`
- **Model**: `deepseek-chat`

## ⚙️ Step 4: Detailed Configuration

### 4.1 Email Monitoring Configuration (Using Environment Variables)

**Recommended Method: Using .env file**

The email monitoring configuration now uses environment variables. You no longer need to manually configure the IMAP node in Node-RED editor.

1. Edit your `.env` file and add your Gmail OAuth2 token:
   ```bash
   GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here
   ```

2. Optional: Configure IMAP server and port (defaults are already set):
   ```bash
   GMAIL_IMAP_SERVER=imap.gmail.com  # Optional, defaults to imap.gmail.com
   GMAIL_IMAP_PORT=993              # Optional, defaults to 993
   ```

3. The flow will automatically use these environment variables when you start Node-RED with the provided script:
   ```bash
   ./start-nodered.sh
   ```

**Note**: 
- The email monitoring node will automatically read `GMAIL_OAUTH_TOKEN` from environment variables
- If you need to use a different email provider, you can set `GMAIL_IMAP_SERVER` and `GMAIL_IMAP_PORT` accordingly
- The token must be a valid OAuth2 access token with Gmail API permissions

### 4.2 API Configuration (Using Environment Variables)

**Recommended Method: Using .env file**

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Edit the `.env` file and add your API keys:
   ```bash
   DEEPSEEK_API_KEY=sk-your-actual-api-key-here
   GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here
   ```

3. Start Node-RED using the provided script (which automatically loads .env):
   ```bash
   ./start-nodered.sh
   ```

   Or manually load environment variables before starting Node-RED:
   ```bash
   export $(cat .env | grep -v '^#' | xargs)
   node-red
   ```

**Alternative Method: Set Environment Variable Directly**

You can also set the environment variable directly before starting Node-RED:
```bash
export DEEPSEEK_API_KEY=sk-your-actual-api-key-here
node-red
```

**Note**: 
- The flow files now automatically read the API key from the `DEEPSEEK_API_KEY` environment variable
- The email monitoring node automatically reads `GMAIL_OAUTH_TOKEN` from environment variables
- You no longer need to manually edit the function nodes or email node configuration

### 4.3 Web Interface Configuration

1. Confirm HTTP input node configuration:
   - Email notification page: `/notifications`
   - API interface: `/api/notifications`
   - Delete interface: `/api/notifications/delete`
   - Clear interface: `/api/notifications/clear`

## 🔐 Step 5: OAuth2 Authentication Configuration

### 5.1 Gmail OAuth2 Setup

1. In Google Cloud Console:
   - Add authorized redirect URI
   - Configure OAuth consent screen
   - Add test users (if needed)

2. Obtain access token:
   ```bash
   # Use OAuth2 tools to obtain access token
   # Or use Google OAuth2 Playground
   ```

### 5.2 Configure Access Token

1. Configure the obtained access token in the email monitoring node
2. Ensure the token has the following permissions:
   - `https://www.googleapis.com/auth/gmail.readonly`
   - `https://www.googleapis.com/auth/gmail.modify`

## 🧪 Step 6: Test Configuration

### 6.1 Manual Testing

1. Use the "Manual Email Test" node to test the flow
2. Check if debug output is normal
3. Verify API calls are successful

### 6.2 Functional Testing

1. Send a test email to the configured mailbox
2. Check if analysis is automatically triggered
3. Verify the web interface displays results

## 🌐 Step 7: Access Web Interface

### 7.1 Start Service

1. Deploy Node-RED flow
2. Access web interface: `http://localhost:1880/notifications`

### 7.2 Interface Features

- **Email Notifications**: View latest email analysis results
- **History Records**: Browse past analysis records
- **Statistics**: View processing statistics
- **Management Functions**: Delete and clear notifications

## 🔧 Advanced Configuration

### 8.1 Custom Analysis Parameters

You can adjust the following parameters to optimize analysis effectiveness:

```javascript
// Adjust in API requests
"max_tokens": 1000,        // Maximum tokens
"temperature": 0.2,        // Creativity level
"model": "deepseek-chat"   // Model used
```

### 8.2 History Record Configuration

```javascript
// Adjust history record retention count
const maxRecords = global.get('emailHistoryLimit') || 30;
```

### 8.3 Notification Management

```javascript
// Adjust notification retention count
if (notifications.length > 20) {
    notifications = notifications.slice(0, 20);
}
```

## 🚨 Troubleshooting

### Common Issues

#### 1. API Call Failures
- Check if API key is correct
- Confirm network connection is normal
- Verify API quota is sufficient

#### 2. Email Monitoring Failures
- Check if OAuth2 token is valid
- Confirm Gmail API is enabled
- Verify mailbox permission settings

#### 3. Web Interface Inaccessible
- Check if Node-RED is running normally
- Confirm port 1880 is not occupied
- Verify firewall settings

### Debugging Tips

1. **Enable Debug Nodes**: Add debug nodes at key locations
2. **Check Logs**: Check Node-RED console output
3. **API Testing**: Use tools like Postman to test API calls
4. **Step-by-step Testing**: Test each functional module separately

## 📊 Monitoring and Maintenance

### Performance Monitoring

- Monitor API call frequency and success rate
- Check email processing latency
- Observe memory usage

### Regular Maintenance

- Regularly update API keys
- Clean up expired history records
- Backup important configurations

## 🔒 Security Recommendations

1. **API Key Security**:
   - ✅ **Already implemented**: API keys are now stored in `.env` file (not hardcoded)
   - Never commit `.env` file to version control (already in `.gitignore`)
   - Use environment variables to store sensitive information
   - Regularly rotate API keys
   - Share `.env.example` (without real keys) as a template

2. **Access Control**:
   - Limit web interface access permissions
   - Use HTTPS for encrypted transmission
   - Configure appropriate firewall rules

3. **Data Protection**:
   - Regularly backup important data
   - Encrypt storage of sensitive information
   - Follow data protection regulations

## 📞 Getting Help

If you encounter problems, you can:

1. Check Node-RED official documentation
2. Check DeepSeek API documentation
3. Submit GitHub Issues
4. Contact technical support

---

**After configuration is complete, your Email AI Assistant is ready to work!** 🎉