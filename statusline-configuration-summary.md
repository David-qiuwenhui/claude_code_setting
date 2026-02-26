# 状态栏配置总结

**日期：** 2026-02-07
**会话：** Claude Code 状态栏设置

---

## 概述

本文档总结了 Claude Code 的状态栏配置设置，该配置模仿了 Powerlevel10k 提示符风格。状态栏直接在 CLI 界面中提供有关开发环境的实时信息。

---

## 完成的工作

### 1. 状态栏代理设置
- 创建了 `/Users/qiuwenhui/.claude/settings.json` 配置文件
- 生成了 `/Users/qiuwenhui/.claude/statusline-command.sh` 自定义脚本

### 2. 依赖安装
- 通过 Homebrew 安装了 `jq`（版本 1.8.1）用于 JSON 解析
- 使状态栏脚本可执行

### 3. Vue AI Skills 仓库
- 将 `vuejs-ai/skills` 仓库克隆到 `skills/` 目录
- 仓库包含 Vue 3 开发代理技能

---

## 状态栏功能

状态栏以类似 Powerlevel10k 的格式显示信息：

| 组件 | 说明 | 颜色 |
|------|------|------|
| **当前目录** | 使用 `~` 表示主目录 | 默认 |
| **Git 分支** | 显示当前分支名称 | 绿色 (32) |
| **Git 状态指示器** | `*` 表示未提交更改，`⇡` 表示领先，`⇣` 表示落后 | 绿色 |
| **模型名称** | 简短显示（Sonnet/Opus/Haiku） | 蓝色 (34) |
| **输出样式** | 仅在非 "default" 时显示 | 洋红色 (35) |
| **上下文使用** | 上下文窗口使用百分比 | 黄色 (33) |
| **Vim 模式** | NORMAL 或 INSERT 模式指示器 | 青色 (36) / 绿色 (32) |
| **代理名称** | 使用 --agent 标志运行时显示 | 红色 (31) |
| **当前时间** | 24 小时格式 (HH:MM:SS) | 灰色 (90) |

---

## 配置选项

### 状态栏脚本位置
```
~/.claude/statusline-command.sh
```

### 设置文件位置
```
~/.claude/settings.json
```

### 颜色代码 (ANSI)
| 代码 | 颜色 |
|------|------|
| `0;32m` | 绿色 |
| `0;34m` | 蓝色 |
| `0;35m` | 洋红色 |
| `0;33m` | 黄色 |
| `0;36m` | 青色 |
| `0;31m` | 红色 |
| `0;90m` | 灰色 |

---

## 输出示例

### 示例 1：基本开发环境
```
~/Documents/validate_claude_code/vue_claude_code | master* | Opus | learning | 25% | NORMAL | my-agent | 19:56:53
```

**解析：**
- 目录：`~/Documents/validate_claude_code/vue_claude_code`
- Git：`master*`（在 master 分支，有未提交更改）
- 模型：`Opus`
- 输出样式：`learning`
- 上下文使用：`25%`
- Vim 模式：`NORMAL`
- 代理：`my-agent`
- 时间：`19:56:53`

### 示例 2：干净的工作目录
```
~ | main | Sonnet | 45% | 20:15:30
```

**解析：**
- 目录：`~`（主目录）
- Git：`main`（干净，无未提交更改）
- 模型：`Sonnet`
- 上下文使用：`45%`
- 时间：`20:15:30`

### 示例 3：Git 状态指示器
```
~/project/my-app | feature-branch*⇡3⇣1 | Haiku | default | 60% | INSERT | 22:30:45
```

**解析：**
- Git：`feature-branch*⇡3⇣1`
  - `*` = 未提交更改
  - `⇡3` = 领先远程分支 3 个提交
  - `⇣1` = 落后远程分支 1 个提交
- Vim 模式：`INSERT`

---

## Git 状态指示器

| 符号 | 含义 |
|------|------|
| `*` | 工作目录有未提交更改 |
| `⇡N` | 领先远程分支 N 个提交 |
| `⇣N` | 落后远程分支 N 个提交 |

---

## 测试状态栏

手动测试状态栏：

```bash
# 使脚本可执行（如果尚未设置）
chmod +x ~/.claude/statusline-command.sh

# 使用模拟输入测试
echo '{"workspace":{"current_dir":"/Users/qiuwenhui/Documents/project"},"model":{"display_name":"Claude Opus 4.6"},"output_style":{"name":"learning"},"context_window":{"remaining_percentage":75,"used_percentage":25},"vim":{"mode":"NORMAL"},"agent":{"name":"my-agent"}}' | ~/.claude/statusline-command.sh
```

---

## 修改状态栏

如需将来修改状态栏配置，使用 **statusline-setup** 代理：

1. 使用代理 ID 恢复：`a94b472`
2. 或启动新的 statusline-setup 任务
3. 指定您的需求（颜色、格式、显示信息）

---

## 已安装的 Vue AI Skills

`skills/` 目录包含以下 Vue 3 开发技能：

| 技能 | 用途 |
|------|------|
| `vue-best-practices` | Vue 3 + Composition API + TypeScript |
| `vue-options-api-best-practices` | Options API 模式 |
| `vue-jsx-best-practices` | Vue 中的 JSX 语法 |
| `vue-testing-best-practices` | Vitest、Vue Test Utils、Playwright |
| `vue-router-best-practices` | Vue Router 4 模式 |
| `vue-pinia-best-practices` | Pinia 状态管理 |
| `vue-debug-guides` | Vue 3 问题调试 |
| `vue-development-guides` | 构建 Vue/Nuxt 项目 |
| `create-adaptable-composable` | 创建可复用的组合式函数 |

---

## 命令参考

```bash
# 检查 jq 安装
which jq && jq --version

# 查看状态栏脚本
cat ~/.claude/statusline-command.sh

# 查看 Claude 设置
cat ~/.claude/settings.json

# 检查 skills 目录中的 git 状态
cd skills && git status
```

---

## 注意事项

- 状态栏由 Claude Code 在会话期间自动更新
- `jq` 是状态栏脚本 JSON 解析所必需的
- 脚本使用 `git --no-optional-locks` 以提高性能
- 时间格式遵循 Powerlevel10k 的 24 小时格式
- 目录路径使用 `~` 缩写主目录

---

## 故障排除

### 问题："jq: command not found"
**解决方案：** 通过 Homebrew 安装 jq：
```bash
brew install jq
```

### 问题：状态栏不显示颜色
**解决方案：** 确保终端支持 ANSI 颜色代码。大多数现代终端默认支持。

### 问题：Git 信息未显示
**解决方案：** 验证您是否在 git 仓库中：
```bash
git rev-parse --git-dir
```

---

*由 Claude Code 生成于 2026-02-07*
