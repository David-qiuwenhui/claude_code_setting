#!/bin/bash
# Claude Code Statusline 卸载脚本
# 用法: bash uninstall.sh
# 功能: 移除 Claude Code 状态栏配置

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SETTINGS_FILE="$HOME/.claude/settings.json"

print_step() {
    printf "${BLUE}→ %s${NC}\n" "$1"
}

print_success() {
    printf "${GREEN}✓ %s${NC}\n" "$1"
}

print_warning() {
    printf "${YELLOW}⚠ %s${NC}\n" "$1"
}

confirm() {
    local prompt="$1 [y/N] "
    read -r response
    [[ "$response" =~ ^[Yy] ]]
}

# 移除状态栏脚本
remove_script() {
    local script="$HOME/.claude/statusline-command.sh"
    if [[ -f "$script" ]]; then
        rm -f "$script"
        print_success "已删除 $script"
    else
        print_warning "未找到 $script，跳过"
    fi
}

# 移除 settings.json 中的 statusLine 配置
remove_config() {
    if [[ ! -f "$SETTINGS_FILE" ]]; then
        print_warning "未找到 $SETTINGS_FILE，跳过"
        return 0
    fi

    # 检查是否包含 statusLine 配置
    local has_config=$(jq -r 'has("statusLine")' "$SETTINGS_FILE" 2>/dev/null)
    if [[ "$has_config" != "true" ]]; then
        print_warning "settings.json 中未找到 statusLine 配置，跳过"
        return 0
    fi

    # 备份
    cp "$SETTINGS_FILE" "${SETTINGS_FILE}.bak"
    print_step "已备份到 ${SETTINGS_FILE}.bak"

    # 移除 statusLine 键
    jq 'del(.statusLine)' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"

    # 检查剩余内容
    local remaining=$(cat "${SETTINGS_FILE}.tmp")
    if [[ "$remaining" == "{}" ]]; then
        echo "settings.json 已无其他配置。"
        if confirm "是否删除整个 settings.json？"; then
            rm -f "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
            print_success "已删除 $SETTINGS_FILE"
        else
            mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
            print_success "已保留空的 settings.json"
        fi
    else
        mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
        print_success "已从 settings.json 中移除 statusLine 配置"
    fi
}

# 主流程
main() {
    echo ""
    print_step "卸载 Claude Code Statusline..."
    echo ""

    remove_script
    remove_config

    echo ""
    print_success "卸载完成！"
    echo ""
    echo "请重启 Claude Code 以使更改生效。"
    echo ""
}

main "$@"
