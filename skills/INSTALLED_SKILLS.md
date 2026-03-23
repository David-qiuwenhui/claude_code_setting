# 本地已安装 Skills 总结

本文档汇总了当前本地已安装的所有 Agent Skills，方便快速查阅和使用。

**生成日期**: 2026-03-23
**Skills 目录**: `skills_repo/`

---

## 概览

本地共安装 **9 个 skills**，分为两大类：

| 类别 | 数量 | 来源 |
|------|------|------|
| Skills 管理工具 | 1 | vercel-labs/agent-skills |
| Vue 3 开发指南 | 8 | vuejs-ai/skills |

---

## 一、Skills 管理工具

### 1. find-skills

- **来源**: `vercel-labs/agent-skills`
- **安装路径**: `skills_repo/vercel-labs-skills/skills/find-skills/`
- **用途**: 帮助用户发现和安装 Agent Skills

**描述**: 当用户询问"如何执行 X 操作"、"查找 X 的 skill"、"是否有 skill 可以..."时，使用此 skill。帮助用户从开放的 agent skills 生态系统中发现和安装技能。

**主要功能**:
- 使用 `npx skills find [query]` 搜索技能
- 使用 `npx skills add <package>` 安装技能
- 提供常见技能类别的搜索建议
- 浏览技能官网: https://skills.sh/

---

## 二、Vue 3 开发指南 Skills

来源: `vuejs-ai/skills` - Vue.js 官方 AI Skills 集合

### 1. vue-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-best-practices/`
- **版本**: 18.0.0
- **作者**: github.com/vuejs-ai

**描述**: **Vue.js 任务必须使用**。强烈推荐使用 Composition API 配合 `<script setup>` 和 TypeScript 作为标准方案。涵盖 Vue 3、SSR、Volar、vue-tsc。

**核心内容**:
- 架构确认和组件边界规划
- 响应式系统（Reactivity）
- 单文件组件（SFC）结构和模板安全
- 组件数据流（props down, events up）
- Composables 设计模式
- 性能优化（虚拟列表、v-once/v-memo 等）

**适用场景**: 任何 Vue、.vue 文件、Vue Router、Pinia 或 Vite with Vue 的工作

---

### 2. create-adaptable-composable

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/create-adaptable-composable/`
- **版本**: 17.0.0
- **作者**: github.com/vuejs-ai

**描述**: 创建库级别的 Vue composable，接受 maybe-reactive 输入（MaybeRef / MaybeRefOrGetter），使调用者可以传递普通值、ref 或 getter。

**核心概念**:
- `MaybeRef<T>`: value 或可写 ref
- `MaybeRefOrGetter<T>`: MaybeRef + ComputedRef + () => T
- 使用 `toValue()`/`toRef()` 规范化输入
- 在 reactive effects（watch/watchEffect）内部保持行为可预测

**适用场景**: 创建可复用、可适配的 composables

**兼容性**: 需要 Vue 3 (或更高) 或 Nuxt 3 (或更高) 项目

---

### 3. vue-router-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-router-best-practices/`
- **版本**: 1.0.0
- **作者**: github.com/vuejs-ai

**描述**: Vue Router 4 模式、导航守卫、路由参数和路由-组件生命周期交互。

**涵盖主题**:
- 导航守卫（Navigation Guards）
  - 同路由不同参数导航
  - beforeRouteEnter 守卫中访问组件实例
  - 异步 API 调用模式
  - 无限重定向循环处理
  - 废弃的 next() 函数替代方案
- 路由生命周期
  - 同路由数据陈旧问题
  - 组件卸载后事件监听器清理
- 生产环境 SPA 配置

---

### 4. vue-pinia-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-pinia-best-practices/`
- **版本**: 1.0.0
- **作者**: github.com/vuejs-ai

**描述**: Pinia stores、状态管理模式、store 设置和与 store 的响应式交互。

**涵盖主题**:
- Store 设置
  - "getActivePinia was called" 错误处理
  - Setup stores 在 DevTools 或 SSR 中缺失状态
- 响应式
  - Store 解构导致 UI 不更新
  - Store 方法在模板调用中丢失上下文
- 状态模式
  - URL 存储临时过滤器状态
  - 大型应用的生产环境配置

---

### 5. vue-options-api-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-options-api-best-practices/`
- **版本**: 2.0.0
- **作者**: github.com/vuejs-ai

**描述**: Vue 3 Options API 风格（data()、methods、this 上下文）。每个参考仅显示 Options API 解决方案。

**涵盖主题**:
- TypeScript 集成
  - 组件属性的类型推断
  - Options API this 上下文的严格类型安全
  - Props 验证器中的箭头函数问题
  - 事件处理器参数类型安全
  - 复杂对象/数组 Props 的接口类型
  - Provide/Inject 的类型限制
  - Computed 返回类型文档
- 方法和生命周期
  - 方法不绑定到组件实例上下文
  - 生命周期钩子无法访问组件数据
  - Debounced 函数在组件实例间共享状态

---

### 6. vue-jsx-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-jsx-best-practices/`
- **版本**: 2.0.0
- **作者**: github.com/vuejs-ai

**描述**: Vue 中的 JSX 语法和与 React JSX 的差异。

**涵盖主题**:
- 从 React JSX 迁移到 Vue JSX
- 属性类型错误处理
- Vue vs React JSX 差异（如 class vs className）

---

### 7. vue-testing-best-practices

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-testing-best-practices/`
- **版本**: 1.0.0
- **作者**: github.com/vuejs-ai

**描述**: 用于 Vue.js 测试。涵盖 Vitest、Vue Test Utils、组件测试、mocking、测试模式，以及 Playwright E2E 测试。

**涵盖主题**:
- 测试基础设施设置
- 黑盒测试方法（重构时测试不中断）
- 异步测试和 race condition 处理
- Composables 测试（生命周期钩子和 inject）
- Pinia store 测试设置
- 异步组件和 Suspense 测试
- 快照测试的局限性
- E2E 测试框架选择（Playwright 推荐）
- 浏览器 vs Node 运行器
- defineAsyncComponent 组件测试
- Teleport 组件测试

**参考资源**:
- [Vue.js Testing Guide](https://vuejs.org/guide/scaling-up/testing)
- [Vue Test Utils](https://test-utils.vuejs.org/)
- [Vitest Documentation](https://vitest.dev/)
- [Playwright Documentation](https://playwright.dev/)

---

### 8. vue-debug-guides

- **安装路径**: `skills_repo/vuejs-ai-skills/skills/vue-debug-guides/`
- **版本**: 未指定

**描述**: Vue 3 调试和错误处理，用于运行时错误、警告、异步失败和 SSR/ hydration 问题。诊断或修复 Vue 问题时使用。

**涵盖主题**:

| 类别 | 问题示例 |
|------|----------|
| **响应式** | 意外重渲染、Ref 值不更新、解构后状态停止更新、嵌套 Refs 渲染为 [object Object] |
| **Computed** | Getter 触发副作用、计算值只读、条件依赖不更新、数组排序破坏原状态 |
| **Watchers** | 异步操作覆盖旧数据、Watcher 永不触发、DOM 读取返回陈旧值 |
| **组件** | 组件未找到、点击事件不触发、父组件无法访问子 ref |
| **Props & Emits** | defineProps 作用域限制、事件未声明、emits 混用类型和运行时参数 |
| **模板** | 模板编译错误、v-if null 检查顺序、v-if 与 v-for 混用 |
| **模板 Refs** | Ref 变为 null、Ref 数组索引不匹配、Vue 3.5 useTemplateRef |
| **表单 & v-model** | 初始值不显示、textarea 插值问题、iOS 下拉框首选项、IME 输入法问题 |
| **事件 & 修饰符** | 修饰符链产生意外结果、键盘快捷键不触发 |
| **生命周期** | 内存泄漏、DOM 访问时机、SSR 渲染差异 |
| **Slots** | 插槽内容返回 undefined、命名与作用域插槽混用错误 |
| **Provide/Inject** | 异步操作后 provide 失败、注入值不更新 |
| **Teleport** | 目标元素不存在、SSR hydration 问题、作用域样式限制 |
| **Suspense** | 异步错误处理、SSR hydration 问题 |
| **SSR** | Hydration mismatch、跨请求状态泄漏、浏览器 API 崩溃 |
| **性能** | Props 不稳定导致重新渲染、Computed 对象触发效果 |
| **SFC** | 命名导出禁止、script setup 响应式、作用域 CSS 限制 |

---

## 使用建议

### 根据任务选择 Skill

| 任务类型 | 推荐 Skill |
|----------|------------|
| 新建 Vue 3 项目/组件 | `vue-best-practices` |
| 创建可复用的组合函数 | `create-adaptable-composable` + `vue-best-practices` |
| Vue Router 相关问题 | `vue-router-best-practices` |
| Pinia 状态管理 | `vue-pinia-best-practices` |
| Options API 项目维护 | `vue-options-api-best-practices` |
| JSX 语法问题 | `vue-jsx-best-practices` |
| 编写测试 | `vue-testing-best-practices` |
| 调试 Vue 问题 | `vue-debug-guides` |
| 查找/安装新 skills | `find-skills` |

### 组合使用

某些场景需要多个 skills 配合：

1. **开发 Vue 3 应用**: `vue-best-practices` (主) + `vue-router-best-practices` + `vue-pinia-best-practices`
2. **编写可复用逻辑**: `vue-best-practices` + `create-adaptable-composable`
3. **调试复杂问题**: `vue-debug-guides` + 相关领域的 best practices skill
4. **维护旧项目**: `vue-options-api-best-practices` + `vue-debug-guides`

---

## 更新和维护

### 检查 Skill 更新

```bash
npx skills check
```

### 更新所有 Skills

```bash
npx skills update
```

### 添加新 Skills

```bash
# 搜索技能
npx skills find [query]

# 安装技能
npx skills add <owner/repo@skill>
```

### 更新子模块

由于 skills_repo 下的仓库是 Git 子模块，如需更新：

```bash
git submodule update --remote
```

---

## 参考链接

- **Skills 官网**: https://skills.sh/
- **Vercel Agent Skills**: https://github.com/vercel-labs/agent-skills
- **Vue.js AI Skills**: https://github.com/vuejs-ai/skills
- **Skills 最佳实践**: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
