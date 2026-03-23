# Claude-Mem 中文使用指南

<div align="center">

**🧠 Claude Code 持久记忆插件**

[![License](https://img.shields.io/badge/License-AGPL%203.0-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-6.5.0-green.svg)](package.json)
[![Node](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen.svg)](package.json)

Claude-Mem 通过自动捕获工具使用观察、生成语义摘要，并在未来会话中提供这些信息，为 Claude Code 提供跨会话的持久记忆能力。

</div>

---

## 📖 目录

- [快速开始](#快速开始)
- [核心功能](#核心功能)
- [安装方式](#安装方式)
- [使用技巧](#使用技巧)
- [搜索工具](#搜索工具)
- [配置说明](#配置说明)
- [常见问题](#常见问题)
- [技术架构](#技术架构)

---

## 🚀 快速开始

### 前置要求

- **Node.js**: 18.0.0 或更高版本
- **Claude Code**: 支持插件的最新版本
- **Bun**: JavaScript 运行时（自动安装）
- **uv**: Python 包管理器（自动安装）

### 推荐安装方式

**全局安装（使所有项目可用）**

```bash
# 切换到 skills_repo 目录
cd /path/to/claude_code_setting/skills_repo

# 全局安装 Claude-Mem
npx skills add ./claude-mem-main -g
```

**项目本地安装**

```bash
# 安装到当前项目
npx skills add ./claude-mem-main
```

### 验证安装

安装完成后，访问 **http://localhost:37777** 查看 Web 查看器界面。

---

## 💎 核心功能

### 1. 持久记忆

Claude-Mem 自动捕获每个会话中的：
- 工具使用观察（`PostToolUse` hook）
- 会话摘要（`Summary` hook）
- 用户提交内容（`UserPromptSubmit` hook）

这些信息被压缩存储，并在新会话开始时自动注入。

### 2. 渐进式披露

采用**3 层记忆检索**策略：

1. **索引层** - 轻量级摘要（50-100 tokens/结果）
2. **时间线层** - 上下文时间线
3. **详情层** - 完整观察数据（500-1,000 tokens/结果）

这样可以节省约 **10 倍的 token 成本**。

### 3. 隐私保护

使用 `<private>` 标签保护敏感内容：

```
<private>
API_KEY=sk-xxxxx
</private>
```

被 `<private>` 包裹的内容不会被存储到记忆数据库中。

---

## 📦 安装方式对比

| 方式 | 命令 | 适用场景 |
| ---- | ---- | ---- |
| **全局 Skills** | `npx skills add ./claude-mem-main -g` | 推荐，所有项目可用 |
| **本地 Skills** | `npx skills add ./claude-mem-main` | 仅当前项目 |
| **Plugin** | `/plugin marketplace add thedotmack/claude-mem` | Claude Code 原生插件方式 |

> ⚠️ **注意**: `npm install -g claude-mem` 只安装 SDK/库，不会注册插件 hooks。

---

## 🔍 使用技巧

### 自然语言查询

在 Claude Code 中直接询问历史：

```
我们之前是怎么处理用户认证的？
上次遇到的内存泄漏问题解决了吗？
搜索所有关于路由配置的修改
```

Claude 会自动调用 `mem-search` 技能进行搜索。

### 技能调用

Claude-Mem 包含以下内置技能：

| 技能 | 功能 | 触发方式 |
| ---- | ---- | ---- |
| **mem-search** | 搜索历史记忆 | 自动或手动调用 |
| **make-plan** | 创建实现计划 | 请求规划时触发 |
| **do** | 执行计划 | 配合 make-plan 使用 |
| **smart-explore** | 结构化代码搜索 | 高效代码探索 |
| **timeline-report** | 生成项目报告 | 请求项目历史时触发 |

---

## 🔎 搜索工具

### MCP 工作流

Claude-Mem 提供 **3 层渐进式搜索**：

```typescript
// 步骤 1: 获取索引
search(query="认证 bug", type="bugfix", limit=10)

// 步骤 2: 查看时间线
timeline(observation_id=123)

// 步骤 3: 获取详情
get_observations(ids=[123, 456, 789])
```

### 搜索参数

| 参数 | 说明 | 示例 |
| ---- | ---- | ---- |
| `query` | 搜索关键词 | `"认证问题"` |
| `type` | 过滤类型 | `"bugfix"`, `"feature"`, `"refactor"` |
| `limit` | 结果数量 | `10` |
| `date_from` | 起始日期 | `"2025-01-01"` |
| `date_to` | 结束日期 | `"2025-12-31"` |

---

## ⚙️ 配置说明

配置文件位置：`~/.claude-mem/settings.json`

```json
{
  "workerPort": 37777,
  "dataDirectory": "~/.claude-mem",
  "logLevel": "info",
  "contextInjection": {
    "maxTokens": 2000,
    "includeTypes": ["observation", "summary"]
  }
}
```

### 主要配置项

| 配置项 | 说明 | 默认值 |
| ---- | ---- | ---- |
| `workerPort` | Web 查看器端口 | `37777` |
| `dataDirectory` | 数据存储目录 | `~/.claude-mem` |
| `logLevel` | 日志级别 | `info` |
| `maxTokens` | 最大注入 tokens | `2000` |

---

## ❓ 常见问题

### Q: 为什么记忆没有出现在新会话中？

A: 检查以下几点：
1. 确认 worker 服务正在运行（访问 http://localhost:37777）
2. 查看 `~/.claude-mem/logs/` 中的日志
3. 确认 `SessionStart` hook 正常执行

### Q: 如何排除敏感信息？

A: 使用 `<private>` 标签包裹敏感内容：
```
<private>
这是敏感内容，不会被存储
</private>
```

### Q: 可以禁用自动记忆吗？

A: 可以通过设置 `contextInjection.enabled = false` 禁用。

### Q: 记忆数据存储在哪里？

A: 默认存储在 `~/.claude-mem/claude-mem.db`（SQLite 数据库）。

---

## 🏗️ 技术架构

### 核心组件

```
┌─────────────────────────────────────────────────┐
│                  Claude Code                    │
├─────────────────────────────────────────────────┤
│  5 个生命周期 Hooks                               │
│  ├─ SessionStart                                 │
│  ├─ UserPromptSubmit                             │
│  ├─ PostToolUse                                  │
│  ├─ Summary                                      │
│  └─ SessionEnd                                   │
├─────────────────────────────────────────────────┤
│           Worker Service (Bun)                   │
│        HTTP API on port 37777                    │
├─────────────────────────────────────────────────┤
│  数据库层 (SQLite + Chroma Vector DB)            │
└─────────────────────────────────────────────────┘
```

### 数据流

1. **捕获**: Hooks 捕获会话事件
2. **处理**: Worker 使用 Agent SDK 生成摘要
3. **存储**: SQLite 存储结构化数据，Chroma 存储向量
4. **检索**: MCP 工具进行渐进式搜索
5. **注入**: 相关记忆注入到新会话

---

## 📚 更多资源

- [官方文档](https://docs.claude-mem.ai/)
- [GitHub 仓库](https://github.com/thedotmack/claude-mem)
- [故障排除指南](https://docs.claude-mem.ai/troubleshooting)
- [配置参考](https://docs.claude-mem.ai/configuration)

---

## 📄 许可证

本项目采用 **GNU Affero General Public License v3.0** (AGPL-3.0) 许可证。

Copyright (C) 2025 Alex Newman (@thedotmack).

---

<div align="center">

**Built with Claude Agent SDK** | **Powered by Claude Code**

</div>
