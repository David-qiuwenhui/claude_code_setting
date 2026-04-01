#!/bin/bash
# Claude Code Statusline 一键安装脚本
# 用法: bash install.sh
# 功能: 安装 Powerlevel10k 风格的状态栏到 Claude Code

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 获取脚本所在目录（兼容符号链接）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SETTINGS_FILE="$HOME/.claude/settings.json"
STATUSLINE_CONFIG='{"statusLine":{"command":"~/.claude/statusline-command.sh","type":"command"}}'

# ============================================
# 辅助函数
# ============================================

print_banner() {
    echo ""
    printf "${CYAN}╔══════════════════════════════════════════╗${NC}\n"
    printf "${CYAN}║   Claude Code Statusline 安装工具       ║${NC}\n"
    printf "${CYAN}║   Powerlevel10k 风格状态栏               ║${NC}\n"
    printf "${CYAN}╚══════════════════════════════════════════╝${NC}\n"
    echo ""
}

print_step() {
    printf "${BLUE}→ %s${NC}\n" "$1"
}

print_success() {
    printf "${GREEN}✓ %s${NC}\n" "$1"
}

print_error() {
    printf "${RED}✗ %s${NC}\n" "$1"
}

print_warning() {
    printf "${YELLOW}⚠ %s${NC}\n" "$1"
}

# 询问用户确认，默认为 No
confirm() {
    local prompt="$1"
    local default="${2:-N}"

    if [[ "$default" == "Y" ]]; then
        prompt="$prompt [Y/n] "
    else
        prompt="$prompt [y/N] "
    fi

    read -r response
    if [[ -z "$response" ]]; then
        response="$default"
    fi

    [[ "$response" =~ ^[Yy] ]]
}

# ============================================
# 步骤 1: 检查操作系统
# ============================================

check_os() {
    local os_name="$(uname)"
    if [[ "$os_name" != "Darwin" && "$os_name" != "Linux" ]]; then
        print_error "不支持的操作系统: $os_name"
        echo "  此脚本仅支持 macOS 和 Linux。"
        echo "  Windows 用户请通过 WSL 运行。"
        exit 1
    fi
    print_success "操作系统: $os_name"
}

# ============================================
# 步骤 2: 检查/安装 jq 依赖
# ============================================

ensure_jq() {
    if command -v jq &>/dev/null; then
        local version=$(jq --version 2>/dev/null || echo "unknown")
        print_success "jq 已安装 ($version)"
        return 0
    fi

    print_warning "jq 未安装"

    local os_name="$(uname)"
    if [[ "$os_name" == "Darwin" ]]; then
        if ! command -v brew &>/dev/null; then
            print_error "未找到 Homebrew，无法自动安装 jq"
            echo "  请手动安装: brew install jq"
            exit 1
        fi
        print_step "正在通过 Homebrew 安装 jq..."
        brew install jq
    elif [[ "$os_name" == "Linux" ]]; then
        if command -v apt &>/dev/null; then
            print_step "正在通过 apt 安装 jq..."
            sudo apt install -y jq
        elif command -v dnf &>/dev/null; then
            print_step "正在通过 dnf 安装 jq..."
            sudo dnf install -y jq
        elif command -v yum &>/dev/null; then
            print_step "正在通过 yum 安装 jq..."
            sudo yum install -y jq
        else
            print_error "无法自动安装 jq，请手动安装后重试"
            exit 1
        fi
    fi

    if command -v jq &>/dev/null; then
        print_success "jq 安装成功"
    else
        print_error "jq 安装失败"
        exit 1
    fi
}

# ============================================
# 步骤 3: 复制状态栏脚本
# ============================================

copy_script() {
    # 确保 ~/.claude 目录存在
    mkdir -p "$HOME/.claude"

    local dest="$HOME/.claude/statusline-command.sh"

    if [[ -f "$dest" ]]; then
        print_warning "检测到已存在 statusline-command.sh"
        if ! confirm "是否覆盖？"; then
            print_step "跳过脚本复制"
            return 0
        fi
    fi

    cp "$SCRIPT_DIR/statusline-command.sh" "$dest"
    chmod +x "$dest"
    print_success "脚本已复制到 $dest"
}

# ============================================
# 步骤 4: 配置 settings.json
# ============================================

configure_settings() {
    # 如果 settings.json 不存在，直接创建
    if [[ ! -f "$SETTINGS_FILE" ]]; then
        echo "$STATUSLINE_CONFIG" | jq '.' > "$SETTINGS_FILE"
        print_success "已创建 $SETTINGS_FILE"
        return 0
    fi

    # 验证现有 settings.json 是否为有效 JSON
    if ! jq empty "$SETTINGS_FILE" 2>/dev/null; then
        print_error "$SETTINGS_FILE 包含无效的 JSON"
        echo "  请手动修复后再试。"
        exit 1
    fi

    # 检查是否已配置 statusLine
    local existing=$(jq -r '.statusLine.command // empty' "$SETTINGS_FILE" 2>/dev/null)
    if [[ "$existing" == "~/.claude/statusline-command.sh" ]]; then
        print_success "statusLine 配置已存在，无需修改"
        return 0
    fi

    if [[ -n "$existing" ]]; then
        print_warning "检测到已存在 statusLine 配置: $existing"
        if ! confirm "是否覆盖为新配置？"; then
            print_step "跳过配置修改"
            return 0
        fi
    fi

    # 备份现有配置
    cp "$SETTINGS_FILE" "${SETTINGS_FILE}.bak"
    print_step "已备份现有配置到 ${SETTINGS_FILE}.bak"

    # 合并配置（原子写）
    jq --argjson overlay "$STATUSLINE_CONFIG" \
       '. + $overlay' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && \
    mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

    print_success "statusLine 配置已写入 $SETTINGS_FILE"
}

# ============================================
# 步骤 5: 打印安装结果
# ============================================

print_result() {
    echo ""
    printf "${GREEN}╔══════════════════════════════════════════╗${NC}\n"
    printf "${GREEN}║          安装完成！                      ║${NC}\n"
    printf "${GREEN}╚══════════════════════════════════════════╝${NC}\n"
    echo ""
    echo "手动测试状态栏："
    echo ""
    echo "  echo '{\"workspace\":{\"current_dir\":\"$HOME\"},\"model\":{\"display_name\":\"Claude Sonnet 4\"},\"context_window\":{\"used_percentage\":25},\"vim\":{\"mode\":\"NORMAL\"}}' | ~/.claude/statusline-command.sh"
    echo ""
    print_warning "请重启 Claude Code 以使状态栏生效。"
    echo ""
}

# ============================================
# 主流程
# ============================================

main() {
    print_banner
    print_step "检查操作系统..."
    check_os

    print_step "检查依赖..."
    ensure_jq

    print_step "安装状态栏脚本..."
    copy_script

    print_step "配置 settings.json..."
    configure_settings

    print_result
}

main "$@"
