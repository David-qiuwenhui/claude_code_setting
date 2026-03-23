# Claude Code Skills 仓库

个人收藏的 Claude Code Agent Skills 集合，用于增强 AI 编程助手的能力。

## 📦 包含的仓库

### 0. Claude-Mem (推荐优先安装)

**仓库地址**: `claude-mem-main`

**官方源**: [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)

> ⭐ **强烈推荐优先安装** - 为 Claude Code 提供跨会话持久记忆功能

Claude-Mem 是一个强大的持久记忆压缩系统，专为 Claude Code 构建。它通过自动捕获工具使用观察、生成语义摘要，并在未来的会话中提供这些信息，使 Claude 能够即使在会话结束或重新连接后，仍能保持对项目知识的连续性。

#### 核心特性

| 特性 | 说明 |
| ---- | ---- |
| 🧠 **持久记忆** | 上下文在会话之间保持存活 |
| 📊 **渐进式披露** | 分层记忆检索，token 成本可见 |
| 🔍 **基于技能的搜索** | 使用 mem-search 技能查询项目历史 |
| 🖥️ **Web 查看器 UI** | 实时记忆流：http://localhost:37777 |
| 💻 **Claude Desktop 技能** | 从 Claude Desktop 对话中搜索记忆 |
| 🔒 **隐私控制** | 使用 `<private>` 标签排除敏感内容 |
| ⚙️ **上下文配置** | 细粒度控制注入的上下文 |
| 🤖 **自动运行** | 无需手动干预 |

#### 安装方式

**推荐：全局安装（使所有项目可用）**

```bash
# 全局安装 Claude-Mem（推荐）
npx skills add ./claude-mem-main -g
```

**标准安装**

```bash
# 安装到当前项目
npx skills add ./claude-mem-main
```

**通过 Claude Code Plugin 安装（备选方案）**

```bash
# 在 Claude Code 会话中执行
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem
```

> **注意**: 虽然也支持 `npm install -g claude-mem`，但这只安装 SDK/库，不会注册插件 hooks 或设置 worker 服务。要作为插件使用，请使用上述命令之一。

#### 系统要求

- **Node.js**: 18.0.0 或更高版本
- **Claude Code**: 支持插件的最新版本
- **Bun**: JavaScript 运行时和进程管理器（如果缺失会自动安装）
- **uv**: Python 包管理器，用于向量搜索（如果缺失会自动安装）
- **SQLite 3**: 持久存储（内置）

#### Web 查看器

安装后，访问 **http://localhost:37777** 查看：
- 实时记忆流
- 项目历史时间线
- 搜索和过滤功能
- 配置设置

#### MCP 搜索工具

Claude-Mem 通过 **4 个 MCP 工具**提供智能记忆搜索，采用节省 token 的**3 层工作流模式**：

1. **`search`** - 获取紧凑索引和 ID（每个结果约 50-100 tokens）
2. **`timeline`** - 获取有趣结果周围的时间上下文
3. **`get_observations`** - 仅获取过滤 ID 的完整详情（每个结果约 500-1,000 tokens）

**使用示例**：
```typescript
// 步骤 1: 搜索索引
search(query="认证 bug", type="bugfix", limit=10)

// 步骤 2: 审查索引，识别相关 ID（例如 #123, #456）

// 步骤 3: 获取完整详情
get_observations(ids=[123, 456])
```

#### 文档资源

- 📚 [完整文档](https://docs.claude-mem.ai/)
- 🚀 [安装指南](https://docs.claude-mem.ai/installation)
- 📖 [使用指南](https://docs.claude-mem.ai/usage/getting-started)
- 🔍 [搜索工具](https://docs.claude-mem.ai/usage/search-tools)
- ⚙️ [配置说明](https://docs.claude-mem.ai/configuration)
- 🐛 [故障排除](https://docs.claude-mem.ai/troubleshooting)

#### 技能说明

Claude-Mem 包含以下内置技能：

| 技能 | 说明 |
| ---- | ---- |
| **mem-search** | 搜索跨会话持久记忆数据库，当用户询问"我们之前解决过这个问题吗？"时自动调用 |
| **make-plan** | 创建详细的分阶段实现计划，包含文档发现功能 |
| **do** | 使用子代理执行分阶段计划 |
| **smart-explore** | 使用 tree-sitter AST 解析进行优化的结构化代码搜索 |
| **timeline-report** | 生成"项目之旅"叙事报告，分析项目的整个开发历史 |

---

### 1. Vercel Labs Skills

**仓库地址**: `vercel-labs-skills`

**官方源**: [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)

Vercel 官方维护的 Agent Skills 生态系统的 CLI 工具和核心技能集合。

#### 包含的 Skills

| Skill           | 说明                                                   |
| --------------- | ------------------------------------------------------ |
| **find-skills** | 交互式搜索和发现可用的技能，帮助用户找到他们需要的功能 |

---

### 2. Vue.js AI Skills

**仓库地址**: `vuejs-ai-skills`

**官方源**: [vuejs-ai/skills](https://github.com/vuejs-ai/skills)

专为 Vue 3 开发设计的 Agent Skills，涵盖 Vue 3 生态系统最佳实践。

#### 包含的 Skills

| Skill                              | 适用场景                             | 说明                                         |
| ---------------------------------- | ------------------------------------ | -------------------------------------------- |
| **vue-best-practices**             | Vue 3 + Composition API + TypeScript | 最佳实践、常见陷阱、SSR 指引、性能优化       |
| **vue-options-api-best-practices** | Options API (`data()`, `methods`)    | `this` 上下文、生命周期、TypeScript 集成     |
| **vue-router-best-practices**      | Vue Router 4                         | 导航守卫、路由参数、路由与组件生命周期       |
| **vue-pinia-best-practices**       | Pinia 状态管理                       | Store 设置、响应式、状态管理模式             |
| **vue-testing-best-practices**     | 编写组件或 E2E 测试                  | Vitest、Vue Test Utils、Playwright           |
| **vue-jsx-best-practices**         | Vue 中的 JSX                         | 与 React JSX 的语法差异                      |
| **vue-debug-guides**               | 调试 Vue 3 问题                      | 运行时错误、警告、异步错误处理、SSR 水合问题 |
| **create-adaptable-composable**    | 创建可复用的 Composables             | `MaybeRef`/`MaybeRefOrGetter` 输入模式       |

## 🚀 安装使用

### 安装单个仓库的 Skills

```bash
# 安装 Vercel Labs Skills
npx skills add ./vercel-labs-skills

# 安装 Vue.js AI Skills
npx skills add ./vuejs-ai-skills
```

### 安装特定 Skill

```bash
# 安装 Vue 最佳实践技能
npx skills add ./vuejs-ai-skills --skill vue-best-practices

# 安装多个技能
npx skills add ./vuejs-ai-skills --skill vue-best-practices --skill vue-router-best-practices
```

### 全局安装

```bash
# 全局安装，使所有项目可用
npx skills add ./vuejs-ai-skills -g
```

### 列出可用技能

```bash
# 列出仓库中的所有技能（不安装）
npx skills add ./vuejs-ai-skills --list
```

## 📋 常用命令

| 命令                         | 说明                         |
| ---------------------------- | ---------------------------- |
| `npx skills list`            | 列出已安装的技能             |
| `npx skills find [query]`    | 交互式搜索或按关键词搜索技能 |
| `npx skills remove [skills]` | 卸载已安装的技能             |
| `npx skills check`           | 检查技能更新                 |
| `npx skills update`          | 更新所有已安装的技能         |

## 💡 使用建议

1. **Vue 开发**: 安装 `vuejs-ai-skills` 中的所有技能，获得完整的 Vue 3 开发支持
2. **技能发现**: 使用 `find-skills` 来探索和发现新的可用技能
3. **明确触发**: 在提示词前加上 "use vue skill" 可以更可靠地触发相应技能

```
使用 vue 技能，创建一个 todo 应用
```

## 🔗 相关资源

- [Agent Skills 规范](https://agentskills.io)
- [Claude Code Skills 文档](https://code.claude.com/docs/en/skills)
- [Skills 目录](https://skills.sh)

## 📄 许可证

各仓库遵循其原有的许可证：

- **Claude-Mem**: AGPL-3.0（GNU Affero General Public License v3.0）
- Vercel Labs Skills: MIT
- Vue.js AI Skills: MIT
