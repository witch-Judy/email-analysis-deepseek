# 🚀 GitHub Codespaces 快速开始指南

这个项目已经完全配置好 GitHub Codespaces，可以在浏览器中直接使用，无需本地安装任何软件！

## ⚡ 一键开始

### 步骤 1: 创建 Codespace

1. 在 GitHub 仓库页面，点击绿色的 **"Code"** 按钮
2. 选择 **"Codespaces"** 标签
3. 点击 **"Create codespace on main"**

等待 1-2 分钟，环境会自动配置完成。

### 步骤 2: 配置 API 密钥

1. 打开项目根目录的 `.env` 文件
2. 编辑并填入你的 API 密钥：

```bash
# DeepSeek API Key
DEEPSEEK_API_KEY=sk-your-actual-api-key-here

# Gmail OAuth2 Token
GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here
```

### 步骤 3: 启动 Node-RED

**好消息！** Node-RED 现在会在 Codespace 启动时自动在后台运行。

如果自动启动失败，可以手动启动：

```bash
# 方法 1: 前台运行（会占用终端）
./start-nodered.sh

# 方法 2: 后台运行（推荐）
bash .devcontainer/start-nodered-background.sh

# 停止 Node-RED
bash .devcontainer/stop-nodered.sh
```

### 步骤 4: 访问 Node-RED

1. 在 VS Code 底部，点击 **"Ports"** 标签
2. 找到端口 **1880** (Node-RED)
3. 点击端口号旁边的 🌐 图标，选择 **"Open in Browser"**

### 步骤 5: 导入 Flow

1. 在 Node-RED 编辑器中，点击右上角菜单（☰）
2. 选择 **"Import"**
3. 选择 `flows/flow-english.json` 或 `flows/flow-chinese.json`
4. 点击 **"Deploy"** 按钮

### 步骤 6: 访问 Web 界面

部署完成后，访问：
```
http://localhost:1880/notifications
```

## 📋 环境变量说明

所有配置都在 `.env` 文件中：

| 变量名 | 说明 | 必需 |
|--------|------|------|
| `DEEPSEEK_API_KEY` | DeepSeek API 密钥 | ✅ 是 |
| `GMAIL_OAUTH_TOKEN` | Gmail OAuth2 令牌 | ✅ 是 |
| `GMAIL_IMAP_SERVER` | IMAP 服务器地址 | ❌ 否（默认：imap.gmail.com）|
| `GMAIL_IMAP_PORT` | IMAP 端口 | ❌ 否（默认：993）|

## 🔍 如何获取 API 密钥

### DeepSeek API Key

1. 访问 [DeepSeek 官网](https://www.deepseek.com/)
2. 注册并登录账号
3. 进入 API 管理页面
4. 创建新的 API 密钥
5. 复制密钥（格式：`sk-xxxxxxxxxxxxxxxx`）

### Gmail OAuth2 Token

1. 访问 [Google Cloud Console](https://console.cloud.google.com/)
2. 创建新项目或选择现有项目
3. 启用 Gmail API
4. 创建 OAuth2 凭据
5. 配置重定向 URI
6. 获取访问令牌

详细步骤请参考 [SETUP.md](SETUP.md)

## 🛠️ 常用命令

```bash
# Node-RED 会在 Codespace 启动时自动运行
# 如果未自动启动，可以使用以下命令：

# 前台启动（占用终端）
./start-nodered.sh

# 后台启动（推荐，不占用终端）
bash .devcontainer/start-nodered-background.sh

# 停止 Node-RED
bash .devcontainer/stop-nodered.sh

# 检查 Node-RED 是否运行
ps aux | grep node-red

# 查看 Node-RED 日志（后台运行时）
tail -f .node-red/logs/nodered.log

# 检查环境变量
cat .env
```

## ❓ 常见问题

### ❌ HTTP ERROR 502 - 无法处理此请求

**问题原因：** 端口已转发，但 Node-RED 服务没有运行。

**解决方法：**

1. **检查 Node-RED 是否运行**
   ```bash
   # 在终端中检查进程
   ps aux | grep node-red
   ```

2. **启动 Node-RED**
   ```bash
   # 使用启动脚本（推荐）
   ./start-nodered.sh
   
   # 或者手动启动
   node-red
   ```

3. **检查端口是否被占用**
   ```bash
   # 检查端口 1880 是否被占用
   lsof -i :1880
   ```

4. **查看 Node-RED 日志**
   - 在运行 Node-RED 的终端中查看错误信息
   - 检查是否有启动错误

5. **确认环境变量已加载**
   ```bash
   # 检查环境变量
   echo $DEEPSEEK_API_KEY
   echo $GMAIL_OAUTH_TOKEN
   ```

### Q: 端口 1880 无法访问？

A: 
1. 检查 VS Code 的 "Ports" 标签
2. 确保端口已转发（应该显示为 "Forwarded"）
3. 点击端口号旁边的图标打开浏览器
4. **重要：** 确保 Node-RED 已经启动（见上面的 502 错误解决方法）

### Q: Node-RED 启动失败？

A:
1. 检查 `.env` 文件是否正确配置
2. 确保所有必需的环境变量都已设置
3. 查看终端错误信息
4. 检查 Node.js 版本：`node --version`（需要 16.x 或更高）

### Q: 端口转发正常但显示 502？

A:
1. **最常见原因：Node-RED 没有启动**
   - 在终端运行 `./start-nodered.sh` 启动 Node-RED
   - 等待看到 "Server now running at http://127.0.0.1:1880/" 消息
   
2. 检查 Node-RED 是否在正确的端口运行
   ```bash
   # 应该看到 node-red 进程
   ps aux | grep node-red
   ```

3. 尝试重启端口转发
   - 在 VS Code 的 "Ports" 标签中
   - 右键点击端口 1880
   - 选择 "Stop Forwarding"，然后重新转发

### Q: API 调用失败？

A:
1. 检查 `DEEPSEEK_API_KEY` 是否正确
2. 确认 API 密钥有效且有足够的配额
3. 查看 Node-RED 的调试输出

### Q: 如何停止 Node-RED？

A: 在运行 Node-RED 的终端中按 `Ctrl+C`

### Q: 如何重启 Node-RED？

A:
```bash
# 方法 1: 使用停止脚本
bash .devcontainer/stop-nodered.sh
bash .devcontainer/start-nodered-background.sh

# 方法 2: 如果在前台运行，按 Ctrl+C 停止，然后重新启动
```

### Q: Node-RED 会自动启动吗？

A: 
- ✅ **是的！** Node-RED 会在 Codespace 启动时自动在后台运行
- 如果自动启动失败，可以手动运行 `bash .devcontainer/start-nodered-background.sh`
- 查看日志：`tail -f .node-red/logs/nodered.log`

## 📚 更多资源

- **详细配置指南**: [SETUP.md](SETUP.md)
- **项目文档**: [README.md](README.md)
- **Codespaces 配置**: [.devcontainer/README.md](.devcontainer/README.md)
- **故障排除**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - 遇到 502 错误？看这里！

## 💡 提示

- ✅ `.env` 文件不会被提交到 Git（已在 .gitignore 中）
- ✅ 修改 `.env` 后需要重启 Node-RED
- ✅ 可以在多个终端标签页中运行不同命令
- ✅ 使用 `&` 可以在后台运行进程

---

**享受在 Codespaces 中使用 Email AI Assistant！** 🎉

