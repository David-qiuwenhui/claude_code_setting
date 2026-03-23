# Skills 目录对比分析报告

**生成时间**: 2026-03-23
**更新时间**: 2026-03-23（已完成迁移）

> **⚠️ 重要更新**: 本文档对比的是**迁移前**的状态。所有 Baoyu 和 Vue skills 已成功迁移到 canonical 位置，详见文末"迁移记录"章节。
**对比目录**:
- `~/.claude/skills/` (Claude Code 专属目录)
- `~/.agents/skills/` (Canonical 通用目录)

---

## 一、总体概况

| 目录 | Skills 数量 | 磁盘占用 | 说明 |
|------|------------|---------|------|
| `~/.claude/skills/` | **35 个** | **5.6M** | Claude Code 专属位置 |
| `~/.agents/skills/` | **6 个** | **128K** | Canonical 通用位置 |

**关键发现**:
- `~/.claude/skills/` 占用的磁盘空间是 `~/.agents/skills/` 的 **44 倍**
- 这是因为大部分 skills 是实际副本，而非符号链接

---

## 二、共同 Skills（6 个）

以下 skills **同时存在于两个目录**：

| 序号 | Skill 名称 | 安装方式 |
|-----|-----------|---------|
| 1 | `do` | 符号链接 → canonical |
| 2 | `git-workflow` | 符号链接 → canonical |
| 3 | `make-plan` | 符号链接 → canonical |
| 4 | `mem-search` | 符号链接 → canonical |
| 5 | `smart-explore` | 符号链接 → canonical |
| 6 | `timeline-report` | 符号链接 → canonical |

**说明**: 这些 skills 通过 `npx skills add` 正确安装，实际文件在 canonical 位置，`~/.claude/skills/` 中只有符号链接。

---

## 三、差异性 Skills（29 个）

以下 skills **只在 `~/.claude/skills/` 中存在**：

### 3.1 Baoyu Content Skills（18 个）

| 序号 | Skill 名称 | 功能描述 |
|-----|-----------|---------|
| 1 | `baoyu-article-illustrator` | 文章配图生成 |
| 2 | `baoyu-comic` | 知识漫画创作 |
| 3 | `baoyu-compress-image` | 图片压缩（WebP/PNG） |
| 4 | `baoyu-cover-image` | 文章封面生成 |
| 5 | `baoyu-danger-gemini-web` | Gemini Web API |
| 6 | `baoyu-danger-x-to-markdown` | X 推文转 Markdown |
| 7 | `baoyu-format-markdown` | Markdown 格式化 |
| 8 | `baoyu-image-gen` | AI 图片生成 |
| 9 | `baoyu-infographic` | 信息图表生成 |
| 10 | `baoyu-markdown-to-html` | Markdown 转 HTML |
| 11 | `baoyu-post-to-wechat` | 发布到微信公众号 |
| 12 | `baoyu-post-to-weibo` | 发布到微博 |
| 13 | `baoyu-post-to-x` | 发布到 X (Twitter) |
| 14 | `baoyu-slide-deck` | 幻灯片生成 |
| 15 | `baoyu-translate` | 文章翻译 |
| 16 | `baoyu-url-to-markdown` | 网页转 Markdown |
| 17 | `baoyu-xhs-images` | 小红书图片生成 |
| 18 | `baoyu-youtube-transcript` | YouTube 字幕下载 |

### 3.2 Vue Skills（7 个）

| 序号 | Skill 名称 | 功能描述 |
|-----|-----------|---------|
| 19 | `vue-best-practices` | Vue 3 最佳实践 |
| 20 | `vue-debug-guides` | Vue 调试指南 |
| 21 | `vue-jsx-best-practices` | Vue JSX 最佳实践 |
| 22 | `vue-options-api-best-practices` | Vue Options API 最佳实践 |
| 23 | `vue-pinia-best-practices` | Pinia 最佳实践 |
| 24 | `vue-router-best-practices` | Vue Router 最佳实践 |
| 25 | `vue-testing-best-practices` | Vue 测试最佳实践 |

### 3.3 Utility Skills（4 个）

| 序号 | Skill 名称 | 功能描述 |
|-----|-----------|---------|
| 26 | `create-adaptable-composable` | 创建可适配 Vue Composable |
| 27 | `find-skills` | 发现和安装 skills |
| 28 | `excalidraw` | Excalidraw 图表工具 |
| 29 | `excalidraw-diagram-generator` | Excalidraw 图表生成器 |

**说明**: 这些 skills 都是**实际文件副本**，通过手动拷贝安装，不在 canonical 位置。

---

## 四、符号链接分析

### 4.1 Canonical 符号链接（6 个）

指向 `~/.agents/skills/` 的相对符号链接：

| Skill | 符号链接路径 | 目标 |
|-------|------------|------|
| `do` | `~/.claude/skills/do` | `../../.agents/skills/do` |
| `git-workflow` | `~/.claude/skills/git-workflow` | `../../.agents/skills/git-workflow` |
| `make-plan` | `~/.claude/skills/make-plan` | `../../.agents/skills/make-plan` |
| `mem-search` | `~/.claude/skills/mem-search` | `../../.agents/skills/mem-search` |
| `smart-explore` | `~/.claude/skills/smart-explore` | `../../.agents/skills/smart-explore` |
| `timeline-report` | `~/.claude/skills/timeline-report` | `../../.agents/skills/timeline-report` |

### 4.2 外部符号链接（2 个）

指向其他位置的符号链接（目前断开）：

| Skill | 符号链接路径 | 目标 | 状态 |
|-------|------------|------|------|
| `excalidraw` | `~/.claude/skills/excalidraw` | `/Users/qiuwenhui/.cc-switch/skills/excalidraw` | ⚠️ 断开 |
| `excalidraw-diagram-generator` | `~/.claude/skills/excalidraw-diagram-generator` | `/Users/qiuwenhui/.cc-switch/skills/excalidraw-diagram-generator` | ⚠️ 断开 |

---

## 五、安装方式对比

| Skills | 安装方式 | Canonical 位置 | 多 Agent 支持 |
|--------|---------|---------------|--------------|
| 6 个共同 skills | `npx skills add` | ✅ `~/.agents/skills/` | ✅ 是 |
| 29 个差异 skills | 手动拷贝 | ❌ 无 | ❌ 否 |

**问题**:
- 手动拷贝的 skills **不在 canonical 位置**
- 其他 agents（Cursor、Copilot、Trae 等）**无法使用**这些 skills
- 重复占用磁盘空间（实际副本 vs 符号链接）

---

## 六、建议

### 6.1 短期建议

1. **修复断开的符号链接**
   - 删除或重新安装 `excalidraw` 相关 skills

2. **统一安装方式**
   - 对于新 skills，使用 `npx skills add <本地路径> -g` 安装
   - 这样可以确保 canonical 位置和多 agent 支持

### 6.2 长期建议

1. **迁移手动拷贝的 skills**
   - 使用 `npx skills add <本地路径> -g` 重新安装 Baoyu 和 Vue skills
   - 删除 `~/.claude/skills/` 中的实际副本

2. **磁盘空间优化**
   - 迁移后可节省约 **5.5M** 空间（实际副本 → 符号链接）

---

## 七、附录：完整 Skills 列表

### ~/.claude/skills/（35 个）

```
baoyu-article-illustrator
baoyu-comic
baoyu-compress-image
baoyu-cover-image
baoyu-danger-gemini-web
baoyu-danger-x-to-markdown
baoyu-format-markdown
baoyu-image-gen
baoyu-infographic
baoyu-markdown-to-html
baoyu-post-to-wechat
baoyu-post-to-weibo
baoyu-post-to-x
baoyu-slide-deck
baoyu-translate
baoyu-url-to-markdown
baoyu-xhs-images
baoyu-youtube-transcript
create-adaptable-composable
do (symlink → ../../.agents/skills/do)
excalidraw (symlink → ~/.cc-switch/skills/excalidraw) [断开]
excalidraw-diagram-generator (symlink → ~/.cc-switch/skills/excalidraw-diagram-generator) [断开]
find-skills
git-workflow (symlink → ../../.agents/skills/git-workflow)
make-plan (symlink → ../../.agents/skills/make-plan)
mem-search (symlink → ../../.agents/skills/mem-search)
smart-explore (symlink → ../../.agents/skills/smart-explore)
timeline-report (symlink → ../../.agents/skills/timeline-report)
vue-best-practices
vue-debug-guides
vue-jsx-best-practices
vue-options-api-best-practices
vue-pinia-best-practices
vue-router-best-practices
vue-testing-best-practices
```

### ~/.agents/skills/（6 个）

```
do
git-workflow
make-plan
mem-search
smart-explore
timeline-report
```

---

**报告生成完毕**

---

## 八、迁移记录（2026-03-23）

### 迁移背景

由于 `npx skills add` 使用本地路径安装时默认采用 `copy` 模式，导致 Baoyu 和 Vue skills 没有正确安装到 canonical 位置。因此采用手动方式创建 canonical 位置和符号链接。

### 迁移方法

使用自定义脚本 `/tmp/migrate-skills.sh` 执行以下操作：
1. 将 skill 文件复制到 `~/.agents/skills/<skill-name>/`（canonical 位置）
2. 删除 `~/.claude/skills/<skill-name>/` 中的实际副本
3. 创建符号链接：`~/.claude/skills/<skill-name>/` → `~/.agents/skills/<skill-name>/`

### 迁移结果

| 项目 | 迁移前 | 迁移后 |
|------|--------|--------|
| `~/.claude/skills/` 磁盘占用 | **5.6M** | **8.0K** |
| `~/.agents/skills/` 磁盘占用 | 128K | **5.7M** |
| Canonical skills 总数 | 6 个 | **32 个** |
| 符号链接数量 | 8 个 | **34 个** |

**节省空间**: ~5.6M

### 已迁移 Skills（26 个）

#### Baoyu Skills（18 个）
- baoyu-article-illustrator
- baoyu-comic
- baoyu-compress-image
- baoyu-cover-image
- baoyu-danger-gemini-web
- baoyu-danger-x-to-markdown
- baoyu-format-markdown
- baoyu-image-gen
- baoyu-infographic
- baoyu-markdown-to-html
- baoyu-post-to-wechat
- baoyu-post-to-weibo
- baoyu-post-to-x
- baoyu-slide-deck
- baoyu-translate
- baoyu-url-to-markdown
- baoyu-xhs-images
- baoyu-youtube-transcript

#### Vue Skills（7 个）
- vue-best-practices
- vue-debug-guides
- vue-jsx-best-practices
- vue-options-api-best-practices
- vue-pinia-best-practices
- vue-router-best-practices
- vue-testing-best-practices

#### Utility Skills（1 个）
- create-adaptable-composable

### 迁移后目录结构

```
~/.agents/skills/              # Canonical 位置（32 个 skills）
├── do
├── git-workflow
├── baoyu-*                    # 18 个 Baoyu skills（实际文件）
├── vue-*                      # 7 个 Vue skills（实际文件）
└── create-adaptable-composable

~/.claude/skills/              # Claude Code 专属位置
├── baoyu-*                    # → ~/.agents/skills/baoyu-* (符号链接)
├── vue-*                      # → ~/.agents/skills/vue-* (符号链接)
├── do                         # → ../../.agents/skills/do (符号链接)
├── git-workflow               # → ../../.agents/skills/git-workflow (符号链接)
├── excalidraw                 # → ~/.cc-switch/skills/excalidraw (断开)
├── excalidraw-diagram-generator # → ~/.cc-switch/skills/... (断开)
└── find-skills                # 实际副本（未迁移）
```

### 后续建议

1. **清理断开的链接**：删除或修复 excalidraw 相关的断开符号链接
2. **迁移 find-skills**：将 find-skills 也迁移到 canonical 位置
3. **统一安装方式**：未来安装新 skills 时，优先使用 `npx skills add <本地路径> -g`，然后手动创建符号链接

### 验证命令

```bash
# 查看 canonical skills
ls -1 ~/.agents/skills/

# 查看符号链接
ls -la ~/.claude/skills/ | grep "^l"

# 查看磁盘占用
du -sh ~/.claude/skills/ ~/.agents/skills/
```
