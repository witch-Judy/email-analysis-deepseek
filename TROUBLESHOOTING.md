# 🔧 故障排除指南

## HTTP ERROR 502 - 无法处理此请求

### 问题描述
访问 Codespaces 中的 Node-RED 时出现 502 错误，提示"目前无法处理此请求"。

### 原因分析
502 错误表示：
- ✅ 端口转发正常工作（否则会显示连接失败）
- ❌ Node-RED 服务没有运行或启动失败

### 解决步骤

#### 步骤 1: 检查 Node-RED 是否运行

在 Codespaces 终端中运行：
```bash
ps aux | grep node-red
```

**如果没有任何输出**，说明 Node-RED 没有运行，需要启动它。

#### 步骤 2: 启动 Node-RED

```bash
# 方法 1: 使用启动脚本（推荐）
./start-nodered.sh

# 方法 2: 手动启动
node-red
```

**等待看到以下消息：**
```
Server now running at http://127.0.0.1:1880/
```

#### 步骤 3: 验证启动成功

启动成功后，你应该能看到：
- 终端显示 "Server now running at http://127.0.0.1:1880/"
- 没有错误信息
- 进程正在运行（`ps aux | grep node-red` 有输出）

#### 步骤 4: 刷新浏览器

启动 Node-RED 后，刷新浏览器页面，应该就能正常访问了。

### 常见启动问题

#### 问题 1: 端口被占用

**错误信息：**
```
Error: listen EADDRINUSE: address already in use :::1880
```

**解决方法：**
```bash
# 查找占用端口的进程
lsof -i :1880

# 杀死占用端口的进程（替换 PID 为实际进程 ID）
kill -9 <PID>
```

#### 问题 2: 环境变量未设置

**错误信息：**
```
⚠️  Warning: DEEPSEEK_API_KEY is not set
```

**解决方法：**
1. 检查 `.env` 文件是否存在
2. 编辑 `.env` 文件，添加必需的 API 密钥
3. 重新启动 Node-RED

#### 问题 3: Node-RED 安装失败

**错误信息：**
```
command not found: node-red
```

**解决方法：**
```bash
# 重新安装 Node-RED
npm install -g --unsafe-perm node-red

# 验证安装
node-red --version
```

### 快速诊断命令

运行以下命令进行快速诊断：

```bash
# 1. 检查 Node-RED 是否运行
ps aux | grep node-red

# 2. 检查端口是否被占用
lsof -i :1880

# 3. 检查环境变量
cat .env

# 4. 检查 Node.js 版本
node --version

# 5. 检查 Node-RED 是否安装
which node-red
```

### 完整重启流程

如果以上方法都不行，尝试完整重启：

```bash
# 1. 停止所有 Node-RED 进程
pkill -f node-red

# 2. 等待几秒
sleep 2

# 3. 检查进程是否已停止
ps aux | grep node-red

# 4. 重新启动
./start-nodered.sh
```

## 其他常见问题

### 端口转发不工作

1. 在 VS Code 中打开 "Ports" 标签
2. 检查端口 1880 是否显示为 "Forwarded"
3. 如果没有，右键点击端口，选择 "Forward Port"
4. 或者手动添加端口转发

### 无法访问 Web 界面

1. 确保 Node-RED 已启动
2. 确保端口已转发
3. 尝试在 VS Code 的 "Ports" 标签中点击端口号旁边的浏览器图标
4. 检查防火墙设置（Codespaces 通常不需要）

### 环境变量不生效

1. 确保 `.env` 文件在项目根目录
2. 确保使用 `./start-nodered.sh` 启动（会自动加载 .env）
3. 或者手动加载：
   ```bash
   export $(cat .env | grep -v '^#' | xargs)
   node-red
   ```

## 获取帮助

如果以上方法都无法解决问题：

1. 查看 Node-RED 的完整日志输出
2. 检查终端中的错误信息
3. 查看 [Node-RED 官方文档](https://nodered.org/docs/)
4. 在 GitHub Issues 中提交问题

