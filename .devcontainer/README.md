# GitHub Codespaces 使用指南

这个项目已经配置好 GitHub Codespaces，可以直接在浏览器中使用，无需本地安装任何软件。

## 🚀 快速开始

### 1. 打开 Codespace

1. 在 GitHub 仓库页面，点击绿色的 "Code" 按钮
2. 选择 "Codespaces" 标签
3. 点击 "Create codespace on main" 或 "New codespace"

### 2. 等待环境初始化

Codespace 会自动：
- 安装 Node.js 和 Node-RED
- 安装所需的 Node-RED 节点
- 创建 `.env` 配置文件模板

### 3. 配置 API 密钥

1. 打开 `.env` 文件
2. 编辑并添加你的 API 密钥：
   ```bash
   DEEPSEEK_API_KEY=sk-your-actual-api-key-here
   GMAIL_OAUTH_TOKEN=your_gmail_oauth_token_here
   ```

### 4. 启动 Node-RED

在终端中运行：
```bash
./start-nodered.sh
```

### 5. 访问 Node-RED

1. 在 VS Code 中，点击底部的 "Ports" 标签
2. 找到端口 1880（Node-RED）
3. 点击端口号旁边的 🌐 图标，选择 "Open in Browser"
4. 或者右键点击端口，选择 "Open in Browser"

### 6. 导入 Flow

1. 在 Node-RED 编辑器中，点击右上角的菜单（☰）
2. 选择 "Import"
3. 选择 `flows/flow-english.json` 或 `flows/flow-chinese.json`
4. 点击 "Deploy" 部署

### 7. 访问 Web 界面

部署完成后，访问：
```
http://localhost:1880/notifications
```

## 📝 重要提示

### 环境变量

所有配置都通过 `.env` 文件管理：
- `DEEPSEEK_API_KEY` - DeepSeek API 密钥（必需）
- `GMAIL_OAUTH_TOKEN` - Gmail OAuth2 令牌（必需）
- `GMAIL_IMAP_SERVER` - IMAP 服务器（可选，默认 imap.gmail.com）
- `GMAIL_IMAP_PORT` - IMAP 端口（可选，默认 993）

### 端口转发

- 端口 1880 会自动转发，你可以在浏览器中直接访问
- 如果端口没有自动打开，可以在 VS Code 的 "Ports" 标签中手动打开

### 持久化存储

- `.env` 文件会被保存，但不会提交到 Git（已在 .gitignore 中）
- Node-RED 的数据存储在 `.node-red` 目录中

## 🔧 故障排除

### Node-RED 无法启动

1. 检查 `.env` 文件是否正确配置
2. 确保环境变量已加载：
   ```bash
   export $(cat .env | grep -v '^#' | xargs)
   node-red
   ```

### 端口无法访问

1. 检查 VS Code 的 "Ports" 标签
2. 确保端口 1880 已转发
3. 尝试手动添加端口转发

### API 调用失败

1. 检查 `DEEPSEEK_API_KEY` 是否正确设置
2. 检查 API 密钥是否有效
3. 查看 Node-RED 的调试输出

## 📚 更多信息

- 详细配置说明：查看 [SETUP.md](../SETUP.md)
- 项目文档：查看 [README.md](../README.md)

## 💡 提示

- 使用 `Ctrl+C` 停止 Node-RED
- 修改 `.env` 文件后需要重启 Node-RED
- 可以在终端中运行多个命令，使用 `&` 在后台运行

