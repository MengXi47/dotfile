#!/usr/bin/env bash
input=$(cat)

JQ=/opt/homebrew/bin/jq

ctx=$(echo "$input" | $JQ -r '.context_window.used_percentage // empty')
h5=$(echo "$input" | $JQ -r '.rate_limits.five_hour.used_percentage // empty')
d7=$(echo "$input" | $JQ -r '.rate_limits.seven_day.used_percentage // empty')
cwd=$(echo "$input" | $JQ -r '.workspace.current_dir // .cwd // empty')

# git 分支:優先用 JSON 的 gitBranch,否則從 cwd 查;detached HEAD 顯示短 SHA
branch=$(echo "$input" | $JQ -r '.gitBranch // empty')
if [ -z "$branch" ] && [ -n "$cwd" ]; then
  branch=$(/usr/bin/git -C "$cwd" branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch=$(/usr/bin/git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

RESET=$'\033[0m'
DIM=$'\033[2m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
CYAN=$'\033[96m'
SEP="${DIM} │ ${RESET}"

# 百分比依用量上色:<50% 綠、50–79% 黃、>=80% 紅;無值顯示 --
pct() {
  local v="$1"
  if [ -z "$v" ]; then printf '%s' "${DIM}--${RESET}"; return; fi
  local n="${v%%.*}"
  local color="$GREEN"
  if [ "$n" -ge 80 ] 2>/dev/null; then color="$RED"
  elif [ "$n" -ge 50 ] 2>/dev/null; then color="$YELLOW"; fi
  printf '%s' "${color}${v}%${RESET}"
}

line="${DIM}Context:${RESET} $(pct "$ctx")${SEP}${DIM}5-Hour:${RESET} $(pct "$h5")${SEP}${DIM}7-Day:${RESET} $(pct "$d7")"
[ -n "$branch" ] && line="${line}${SEP}${CYAN}⎇ ${branch}${RESET}"
printf '%s\n' "$line"
