# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库用途

这是个人 Claude Code 配置与技巧仓库，用于存储配置文件、Skills、Plugins 和使用复盘记录。仓库本身不是应用程序项目，而是 Claude Code 工具的知识库和配置集合。

## 仓库结构

```
.
├── docs/              # 使用文档和复盘记录（如状态栏配置总结）
├── skills_repo/       # Skills 子模块仓库
│   ├── vercel-labs-skills/    # Vercel 官方 Agent Skills CLI
│   └── vuejs-ai-skills/       # Vue 3 专用 Agent Skills
├── plugins_repo/      # MCP Plugins 插件目录（当前为空）
└── README.md
```

## Skills 仓库

### vercel-labs-skills

**来源**: [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)

Vercel 官方的 Agent Skills 生态系统 CLI 工具，用于管理和安装 Skills。

**常用命令**:
```bash
# 列出已安装的技能
npx skills list

# 搜索可用技能
npx skills find [query]

# 安装技能
npx skills add <path-to-skill>

# 卸载技能
npx skills remove <skill-name>

# 检查更新
npx skills check

# 更新所有技能
npx skills update
```

**构建与测试** (需要 Node.js >= 18, pnpm):
```bash
cd skills_repo/vercel-labs-skills
pnpm install              # 安装依赖
pnpm build               # 构建项目
pnpm test                # 运行测试
pnpm type-check          # TypeScript 类型检查
pnpm format              # 格式化代码
```

### vuejs-ai-skills

**来源**: [vuejs-ai/skills](https://github.com/vuejs-ai/skills)

Vue 3 专用 Agent Skills 集合，包含 Vue 3、Composition API、Vue Router、Pinia、测试和调试等最佳实践。

**包含的 Skills**:
- `vue-best-practices` - Vue 3 + Composition API + TypeScript
- `vue-options-api-best-practices` - Options API 模式
- `vue-router-best-practices` - Vue Router 4
- `vue-pinia-best-practices` - Pinia 状态管理
- `vue-testing-best-practices` - Vitest、Vue Test Utils、Playwright
- `vue-jsx-best-practices` - Vue 中的 JSX 语法
- `vue-debug-guides` - Vue 3 问题调试
- `create-adaptable-composable` - 创建可复用的 Composables

## 文档记录

### docs/statusline-configuration-summary.md

记录了 Powerlevel10k 风格的状态栏配置，包括：
- 状态栏脚本位置：`~/.claude/statusline-command.sh`
- 配置文件位置：`~/.claude/settings.json`
- 依赖：`jq` (通过 Homebrew 安装)
- Git 状态指示器：`*` (未提交更改)、`⇡N` (领先 N 个提交)、`⇣N` (落后 N 个提交)

## 常用 Claude Code 命令

```bash
claude --version          # 查看版本
claude skills             # 列出可用 skills
claude --help             # 帮助信息
```

## Git 子模块

`skills_repo` 目录下的仓库是 Git 子模块。如果需要更新子模块：

```bash
git submodule update --remote
```
