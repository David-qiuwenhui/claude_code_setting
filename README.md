# Claude Code 配置与技巧仓库

<div align="center">

**🤖 专注于 Claude Code 的高效使用与最佳实践**

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude-Code-purple.svg)](https://claude.com/claude-code)

</div>

---

## 📖 简介

本仓库是个人使用 [Claude Code](https://claude.com/claude-code) 的配置文件、技巧、Skills、Plugins 和使用复盘的知识库。旨在记录和分享 Claude Code 的使用经验，提升开发效率。

---

## 📁 仓库结构

```
.
├── docs/              # 使用文档和复盘记录
├── skills_repo/       # 自定义 Skills 脚本
├── plugins_repo/      # MCP Plugins 插件
├── .gitignore         # Git 忽略配置
└── README.md          # 本文件
```

### 目录说明

| 目录            | 说明                                                          |
| --------------- | ------------------------------------------------------------- |
| `docs/`         | 存放使用过程中的文档记录、问题复盘、学习笔记等                |
| `skills_repo/`  | 自定义的 Claude Code Skills 脚本，用于扩展 Claude Code 的能力 |
| `plugins_repo/` | MCP (Model Context Protocol) 插件配置和代码                   |

---

## 🚀 快速开始

### 前置要求

- [Claude Code](https://claude.com/claude-code) CLI 工具
- 基本的命令行操作知识

### 配置步骤

1. **克隆仓库**

   ```bash
   git clone https://github.com/qiuwenhui/claude_code_setting.git
   cd claude_code_setting
   ```

2. **安装 Skills**

   ```bash
   # 将 skills_repo 中的脚本复制到 Claude Code skills 目录
   cp -r skills_repo/* ~/.claude/skills/
   ```

3. **配置 Plugins**
   ```bash
   # 根据插件说明进行 MCP 服务器配置
   ```

---

## 📚 内容概览

### 文档资料 (`docs/`)

- 使用技巧与最佳实践
- 问题排查与解决方案
- 功能特性学习笔记
- 项目复盘与经验总结

### 自定义 Skills (`skills_repo/`)

存放扩展 Claude Code 功能的自定义脚本，用于特定场景的自动化任务。

### Plugins (`plugins_repo/`)

集成 MCP 服务器，扩展 Claude Code 的外部服务交互能力。

---

## 🛠️ 常用命令

```bash
# 查看 Claude Code 版本
claude --version

# 查看所有可用的 skills
claude skills

# 查看帮助信息
claude --help
```

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来完善这个知识库！

---

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源协议。

---

## 📮 联系方式

如有问题或建议，欢迎通过以下方式联系：

- GitHub Issues: [提交问题](https://github.com/qiuwenhui/claude_code_setting/issues)
- Email: your-email@example.com

---

<div align="center">

Made with ❤️ by [qiuwenhui](https://github.com/qiuwenhui)

</div>
