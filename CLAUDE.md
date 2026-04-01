# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库用途

这是个人 Claude Code 配置与技巧仓库，用于存储配置文件、Skills、Plugins 和使用复盘记录。仓库本身不是应用程序项目，而是 Claude Code 工具的知识库和配置集合。

## 仓库结构

```
.
├── docs/              # 使用文档和复盘记录
├── skills/            # Skills 说明文档和 Claude-Mem 文档
├── plugins_repo/      # MCP Plugins 插件目录（当前为空）
├── scripts/           # 辅助脚本（如手动安装 Skills）
└── README.md
```

## Skills 管理

**已安装 Skills 详细列表**: 见 `skills/INSTALLED_SKILLS.md`

**Skills 说明和工具概览**: 见 `skills/README.md`

**常用管理命令**:
```bash
npx skills list              # 列出已安装的技能
npx skills find [query]      # 搜索可用技能
npx skills add <path>        # 安装技能
npx skills remove <name>     # 卸载技能
npx skills check             # 检查更新
npx skills update            # 更新所有技能
```

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

## Git 提交工作流程

**重要**: 在执行 `git commit` 之前，必须先展示提交信息供用户确认。

**流程**:
1. 先执行 `git add` 暂存文件
2. 展示暂存的内容和提交信息
3. 等待用户确认（回复"确认"或"OK"）
4. 确认后再执行 `git commit`

**示例**:
```bash
# 步骤 1: 暂存文件并展示差异
git add <files> && git diff --cached

# 步骤 2: 向用户展示以下信息
# - 提交标题
# - 提交正文
# - 等待用户确认

# 步骤 3: 用户确认后执行提交
git commit -m "提交标题

提交正文内容"
```

**提交作者格式**:
```
Co-Authored-By: GLM-4.7 <noreply@glm.com>
```
**注意**: 只使用 GLM-4.7 作为 co-author，不使用 Claude 或其他模型名称，除非用户明确要求。

## 开发规范

### 文档语言约定

- **默认语言**: 创建文档时默认使用中文
- **英文例外**: 仅在用户明确要求时使用英文
- **代码注释**: 代码中的注释使用中文（除非是引用外部文档或专有名词）

**示例**:
```
✅ 正确: 创建一个 README.md 文件，用中文介绍项目
❌ 错误: Create a README.md file in English (除非用户明确要求)
```

### 任务执行模式

**直接执行原则**: 当用户请求创建文件或实现功能时，直接执行，避免过度规划。

**适用场景**:
- 创建文档文件（README.md、CLAUDE.md 等）
- 创建配置文件
- 实现明确的功能需求
- 创建 Excalidraw 图表

**不适用场景**（需要规划）:
- 复杂的架构重构（涉及 5+ 文件）
- 多种实现方案需要选择
- 需要探索现有代码库才能理解需求

**示例**:
```
✅ 正确: "创建一个 README.md 文件" → 直接创建文件
❌ 错误: "创建一个 README.md 文件" → 进入规划模式，创建探索代理

✅ 正确: "重构认证系统" → 进入规划模式，分析现有代码
```

### 插件与技能安装

**验证优先原则**: 安装任何 marketplace 插件或技能前，先验证其可用性。

**流程**:
1. 先搜索或验证插件/技能是否存在
2. 检查是否已安装
3. 再执行安装命令

**示例**:
```bash
# 步骤 1: 验证插件是否存在
npx skills find <plugin-name>

# 步骤 2: 如果不存在，告知用户并建议替代方案
# 步骤 3: 如果存在，执行安装
npx skills add <plugin-name>
```

### Skills 安装规范

**规范路径**: 所有 Skills 应安装到规范目录 `~/.agents/skills/`，再通过符号链接到 `~/.claude/skills/`。

**原因**: 规范目录可被多个 AI 工具共享（Claude Code、Cursor、Copilot 等），避免重复安装。

**手动安装**: 使用 `scripts/install-skill-manual.sh` 脚本：
```bash
./scripts/install-skill-manual.sh <skill源目录>
```

**npx 安装**:
```bash
npx skills add <skill-path>  # 自动安装到规范目录
```

### 测试相关

**localStorage 和异步操作**:
- 在测试中使用 localStorage 时，必须正确 mock
- 异步操作使用适当的 await 时序
- 确保测试清理（cleanup）完整

**示例**:
```typescript
// 正确的 localStorage mock
beforeEach(() => {
  const localStorageMock = {
    getItem: vi.fn(),
    setItem: vi.fn(),
    clear: vi.fn(),
  };
  vi.stubGlobal('localStorage', localStorageMock);
});

// 异步操作等待
await waitFor(() => {
  expect(wrapper.text()).toContain('登录成功');
});
```

### 项目设置验证

**文件创建前验证**: 创建新文件前，确认项目状态：
- 项目是否为空项目
- 是否需要先分析现有代码库
- 是否会覆盖现有文件

**处理方式**:
```bash
# 空项目：直接创建
# 非空项目：先询问用户或分析现有结构
```

### 架构与设计

**可视化优先**: 实现复杂功能前，先用 Excalidraw 画出架构图或流程图，确认方案后再编码。

**里程碑式提交**: 偏好在关键节点提交，而非每次小改动都提交。一个功能完成后做一次有意义的提交。

**子任务委派**: 复杂配置任务（如状态栏脚本、Skills 迁移）适合委派给子代理执行。
