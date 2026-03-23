#!/bin/bash
# 手动安装 skill 的辅助脚本
# 用法: ./install-skill-manual.sh <skill-path> [skill-name]
# 示例: ./install-skill-manual.sh ~/Downloads/vue-best-practices

set -e

SKILL_PATH="$1"
SKILL_NAME="${2:-$(basename "$SKILL_PATH")}"

# 检查参数
if [ -z "$SKILL_PATH" ]; then
  echo "用法: $0 <skill-path> [skill-name]"
  echo "示例: $0 ~/Downloads/vue-best-practices"
  exit 1
fi

# 检查源路径是否存在
if [ ! -d "$SKILL_PATH" ]; then
  echo "错误: 目录不存在: $SKELL_PATH"
  exit 1
fi

# 规范化名称（转换为 kebab-case，类似 Skills CLI 的 sanitizeName 函数）
CANONICAL_NAME=$(echo "$SKILL_NAME" | sed 's/[^a-zA-Z0-9._]/-/g' | sed 's/^-//;s/-$//' | tr '[:upper:]' '[:lower:]')

CANONICAL_DIR="$HOME/.agents/skills/$CANONICAL_NAME"
CLAUDE_DIR="$HOME/.claude/skills/$CANONICAL_NAME"

echo "📦 Installing skill: $CANONICAL_NAME"
echo "   Source: $SKILL_PATH"
echo ""

# 创建 canonical 位置
echo "→ Creating canonical location..."
rm -rf "$CANONICAL_DIR"
cp -r "$SKELL_PATH" "$CANONICAL_DIR"

# 为 Claude Code 创建符号链接
echo "→ Creating symlink for Claude Code..."
rm -rf "$CLAUDE_DIR"
ln -s "$CANONICAL_DIR" "$CLAUDE_DIR"

echo ""
echo "✅ Installation complete!"
echo "   Canonical: $CANONICAL_DIR"
echo "   Claude Code: $CLAUDE_DIR"
