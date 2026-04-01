# Claude Code Powerlevel10k 风格状态栏

为 Claude Code 提供 Powerlevel10k 风格的状态栏，在 CLI 界面中实时显示开发环境信息。

## 效果展示

```
~/Documents/my-project | master*⇡2 | Opus | learning | 25% | NORMAL | my-agent | 19:56:53
```

### 显示组件

| 组件 | 说明 | 颜色 |
|------|------|------|
| **当前目录** | 使用 `~` 缩写主目录路径 | 默认 |
| **Git 分支** | 当前分支名称 + 状态指示器 | 绿色 |
| **模型名称** | 自动缩写（Sonnet/Opus/Haiku） | 蓝色 |
| **输出样式** | 仅在非 default 时显示 | 洋红色 |
| **上下文使用** | 上下文窗口使用百分比 | 黄色 |
| **Vim 模式** | NORMAL 或 INSERT 模式 | 青色/绿色 |
| **代理名称** | 使用 --agent 标志时显示 | 红色 |
| **当前时间** | 24 小时格式 (HH:MM:SS) | 灰色 |

### Git 状态指示器

| 符号 | 含义 |
|------|------|
| `*` | 工作目录有未提交更改 |
| `⇡N` | 领先远程分支 N 个提交 |
| `⇣N` | 落后远程分支 N 个提交 |

### 更多示例

**干净的工作目录：**
```
~ | main | Sonnet | 45% | 20:15:30
```

**有 Git 领先/落后的分支：**
```
~/project/my-app | feature-branch*⇡3⇣1 | Haiku | 60% | INSERT | 22:30:45
```

## 依赖要求

- **jq** — JSON 解析工具（安装脚本会自动安装）
- **git** — 版本控制（通常已预装）
- **bash** — 脚本运行环境

## 安装

```bash
# 进入工具目录
cd tools/statusline

# 一键安装
bash install.sh
```

安装完成后，**重启 Claude Code** 即可看到状态栏。

## 卸载

```bash
bash tools/statusline/uninstall.sh
```

## 手动测试

安装后可手动验证脚本是否正常工作：

```bash
echo '{"workspace":{"current_dir":"'$HOME'"},"model":{"display_name":"Claude Sonnet 4"},"context_window":{"used_percentage":25},"vim":{"mode":"NORMAL"}}' | ~/.claude/statusline-command.sh
```

预期输出：
```
~ | Sonnet | 25% | NORMAL | 19:56:53
```

## 自定义修改

### 修改颜色

编辑 `statusline-command.sh`，修改 ANSI 颜色代码：

| 代码 | 颜色 |
|------|------|
| `\033[0;31m` | 红色 |
| `\033[0;32m` | 绿色 |
| `\033[0;33m` | 黄色 |
| `\033[0;34m` | 蓝色 |
| `\033[0;35m` | 洋红色 |
| `\033[0;36m` | 青色 |
| `\033[0;90m` | 灰色 |

### 修改显示组件

编辑 `statusline-command.sh` 中对应的代码段，注释掉不需要的组件即可。

### 模型名称缩写规则

脚本会将模型名称自动缩写：
- 包含 "Sonnet" → 显示 `Sonnet`
- 包含 "Opus" → 显示 `Opus`
- 包含 "Haiku" → 显示 `Haiku`
- 其他名称 → 原样显示

可在脚本的 `case` 语句中添加更多规则。

## 故障排除

### "jq: command not found"

手动安装 jq：
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# CentOS/RHEL
sudo yum install jq
```

### 状态栏不显示颜色

确保终端支持 ANSI 颜色代码。大多数现代终端（iTerm2、Terminal.app、Windows Terminal）默认支持。

### Git 信息未显示

确认当前目录是 git 仓库：
```bash
git rev-parse --git-dir
```

### 状态栏完全不显示

1. 检查脚本是否有执行权限：`ls -la ~/.claude/statusline-command.sh`
2. 检查 settings.json 配置：`cat ~/.claude/settings.json | jq '.statusLine'`
3. 重启 Claude Code

## 文件说明

| 文件 | 说明 |
|------|------|
| `statusline-command.sh` | 状态栏脚本，读取 JSON stdin 输出格式化状态栏 |
| `install.sh` | 一键安装脚本 |
| `uninstall.sh` | 卸载脚本 |
| `README.md` | 本文档 |
