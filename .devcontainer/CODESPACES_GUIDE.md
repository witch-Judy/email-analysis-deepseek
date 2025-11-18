# 📖 GitHub Codespaces 使用指南

## 🎯 什么是 Codespaces？

GitHub Codespaces 是一个基于云的开发环境，可以直接在浏览器中使用，无需本地安装任何软件。

## 🌿 关于分支（Branch）

### Codespaces 和分支的关系

- **Codespaces 是基于 GitHub 仓库的某个分支创建的**
- 你可以在任何分支上创建 Codespaces
- 默认情况下，Codespaces 会基于你当前选中的分支

### 如何在 main 分支上创建 Codespaces？

#### 方法 1: 从仓库主页创建（推荐）

1. **打开你的 GitHub 仓库**
   - 访问：`https://github.com/witch-Judy/email-analysis-deepseek`

2. **确保在 main 分支**
   - 查看仓库页面左上角，应该显示 `main` 分支
   - 如果不是，点击分支下拉菜单，选择 `main`

3. **创建 Codespace**
   - 点击绿色的 **"Code"** 按钮
   - 选择 **"Codespaces"** 标签
   - 点击 **"Create codespace on main"** 或 **"+"** 按钮

#### 方法 2: 从分支选择器创建

1. 在仓库页面，点击分支下拉菜单（显示当前分支名称的地方）
2. 选择 `main` 分支
3. 然后点击 "Code" → "Codespaces" → "Create codespace"

#### 方法 3: 使用 GitHub CLI（高级）

```bash
gh codespace create --repo witch-Judy/email-analysis-deepseek --branch main
```

## 🔄 切换分支

### 在 Codespaces 中切换分支

如果你已经在 Codespaces 中，但想切换到 main 分支：

```bash
# 查看当前分支
git branch

# 切换到 main 分支
git checkout main

# 或者
git switch main

# 拉取最新代码
git pull origin main
```

### 在 GitHub 网页上切换

1. 在仓库页面，点击分支下拉菜单
2. 选择 `main` 分支
3. 如果需要，可以创建新的 Codespace

## 📍 如何确认当前分支？

### 在 GitHub 网页上

- 查看仓库页面左上角的分支名称
- 应该显示 `main` 或你当前选中的分支

### 在 Codespaces 终端中

```bash
# 查看当前分支
git branch

# 查看所有分支
git branch -a

# 查看当前分支和远程分支的关系
git status
```

## 🆕 创建新的 Codespace

### 步骤详解

1. **访问仓库**
   ```
   https://github.com/witch-Judy/email-analysis-deepseek
   ```

2. **确认分支**
   - 页面左上角应该显示 `main`
   - 如果不是，点击并选择 `main`

3. **打开 Codespaces 菜单**
   - 点击绿色的 **"Code"** 按钮
   - 选择 **"Codespaces"** 标签

4. **创建 Codespace**
   - 点击 **"Create codespace on main"**
   - 或者点击 **"+"** 按钮

5. **等待创建**
   - 通常需要 1-2 分钟
   - 会自动打开 VS Code 界面

## 🔍 常见问题

### Q: 我的 Codespace 在哪个分支上？

A: 在 Codespaces 终端中运行：
```bash
git branch
```
显示 `* main` 表示在 main 分支上。

### Q: 如何确保 Codespace 使用 main 分支？

A: 
1. 在创建 Codespace 之前，确保 GitHub 仓库页面显示的是 `main` 分支
2. 或者在 Codespaces 中运行 `git checkout main`

### Q: 可以同时在多个分支上创建 Codespaces 吗？

A: 可以！每个分支可以有自己的 Codespace。但通常建议：
- 在 main 分支上创建主要的 Codespace
- 其他分支可以临时创建 Codespace 进行测试

### Q: Codespace 创建后，分支会变吗？

A: 
- Codespace 创建时基于哪个分支，就会在那个分支上
- 你可以在 Codespace 中切换分支，但建议保持与 GitHub 上的分支一致

## 💡 最佳实践

1. **主要开发在 main 分支**
   - 在 main 分支上创建主要的 Codespace
   - 这样可以确保使用最新的稳定代码

2. **功能分支单独创建**
   - 如果需要在其他分支上工作，可以创建新的 Codespace
   - 或者在同一 Codespace 中切换分支

3. **定期同步**
   ```bash
   git pull origin main
   ```
   确保代码是最新的

## 🎯 快速检查清单

创建 Codespace 前，确认：
- ✅ GitHub 仓库页面显示 `main` 分支
- ✅ 点击 "Code" → "Codespaces"
- ✅ 选择 "Create codespace on main"
- ✅ 等待创建完成（1-2 分钟）

创建后，确认：
- ✅ 在终端运行 `git branch`，显示 `* main`
- ✅ 运行 `git status`，显示 "On branch main"
- ✅ Node-RED 自动启动（或手动运行 `./start-nodered.sh`）

