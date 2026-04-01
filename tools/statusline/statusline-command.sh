#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract fields using jq
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty' 2>/dev/null)
agent_name=$(echo "$input" | jq -r '.agent.name // empty' 2>/dev/null)

# Get current time (24-hour format like Powerlevel10k)
current_time=$(date +%H:%M:%S)

# Get git branch and status (if in a git repo)
git_info=""
git_dir=$(git -C "$cwd" --no-optional-locks rev-parse --git-dir 2>/dev/null)
if [ -n "$git_dir" ]; then
    # Get branch name
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_info=" $branch"

        # Get git status summary
        if [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
            git_info="${git_info}*"
        fi

        # Check if ahead/behind remote
        ahead_behind=$(git -C "$cwd" --no-optional-locks rev-list --left-right --count '@{u}...HEAD' 2>/dev/null)
        if [ -n "$ahead_behind" ]; then
            ahead=$(echo "$ahead_behind" | awk '{print $2}')
            behind=$(echo "$ahead_behind" | awk '{print $1}')
            if [ "$ahead" != "0" ] && [ "$ahead" != "" ]; then
                git_info="${git_info}⇡${ahead}"
            fi
            if [ "$behind" != "0" ] && [ "$behind" != "" ]; then
                git_info="${git_info}⇣${behind}"
            fi
        fi
    fi
fi

# Get relative path from home directory (like Powerlevel10k)
if [ "$cwd" = "$HOME" ]; then
    dir_display="~"
else
    dir_display=$(echo "$cwd" | sed "s|^$HOME|~|")
fi

# Build the status line
# Format: directory | git branch | model | context | time
status_line=""

# Add directory (shortened if needed)
status_line="$dir_display"

# Add git info if present
if [ -n "$git_info" ]; then
    status_line="$status_line |$(printf '%b' "\033[0;32m")${git_info}$(printf '%b' "\033[0m")"
fi

# Add model name (truncated if too long)
if [ -n "$model" ]; then
    # Shorten model name for display
    case "$model" in
        *"Sonnet"*) model_short="Sonnet" ;;
        *"Opus"*) model_short="Opus" ;;
        *"Haiku"*) model_short="Haiku" ;;
        *) model_short="$model" ;;
    esac
    status_line="$status_line |$(printf '%b' "\033[0;34m") ${model_short}$(printf '%b' "\033[0m")"
fi

# Add output style if not default
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
    status_line="$status_line |$(printf '%b' "\033[0;35m") ${output_style}$(printf '%b' "\033[0m")"
fi

# Add context window usage
if [ -n "$used" ]; then
    status_line="$status_line |$(printf '%b' "\033[0;33m") ${used}%$(printf '%b' "\033[0m")"
fi

# Add vim mode indicator
if [ -n "$vim_mode" ]; then
    if [ "$vim_mode" = "NORMAL" ]; then
        status_line="$status_line |$(printf '%b' "\033[0;36m")NORMAL$(printf '%b' "\033[0m")"
    elif [ "$vim_mode" = "INSERT" ]; then
        status_line="$status_line |$(printf '%b' "\033[0;32m")INSERT$(printf '%b' "\033[0m")"
    fi
fi

# Add agent name if present
if [ -n "$agent_name" ]; then
    status_line="$status_line |$(printf '%b' "\033[0;31m")${agent_name}$(printf '%b' "\033[0m")"
fi

# Add time (right-aligned in concept, but we'll add at end)
status_line="$status_line | $(printf '%b' "\033[0;90m")${current_time}$(printf '%b' "\033[0m")"

# Print the status line
printf '%b' "$status_line"
