#!/bin/bash
input=$(cat)
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
FIVE_H=$(echo "$input"  | jq -r '.rate_limits.five_hour.used_percentage // empty')
SEVEN_D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
SESSION_ID=$(echo "$input" | jq -r '.session_id')

make_bar() {
    local pct=$1 width=${2:-20}
    local filled=$(( pct * width / 100 ))
    local bar=""
    local c_fill=$'\e[38;2;218;119;86m'  # Claude brand color #DA7756
    local c_empty=$'\e[0m'  # terminal default color
    local c_reset=$'\e[0m'
    if [ "$filled" -ge "$width" ]; then
        # 100%: all filled, no head, no empty
        printf -v f "%${width}s" && bar="${c_fill}${f// /━}${c_reset}"
    elif [ "$pct" -eq 0 ]; then
        # 0%: head first, then all empty
        local empty=$(( width - 1 ))
        printf -v e "%${empty}s" && bar="${c_fill}╸${c_empty}${e// /─}"
    else
        # General case: filled ━'s, then head ╸, then empty ─'s
        local empty=$(( width - filled - 1 ))
        [ "$filled" -gt 0 ] && printf -v f "%${filled}s" && bar="${c_fill}${f// /━}"
        bar="${bar}╸${c_reset}"
        [ "$empty"  -gt 0 ] && printf -v e "%${empty}s"  && bar="${bar}${c_empty}${e// /─}"
    fi
    printf '%s' "$bar"
}

GIT_CACHE_FILE="/tmp/claude-statusline-git-$SESSION_ID"
GIT_CACHE_MAX_AGE=5

git_cache_is_stale() {
    [ ! -f "$GIT_CACHE_FILE" ] || \
    [ $(( $(date +%s) - $(stat -f %m "$GIT_CACHE_FILE" 2>/dev/null || stat -c %Y "$GIT_CACHE_FILE" 2>/dev/null || echo 0) )) -gt $GIT_CACHE_MAX_AGE ]
}

if git_cache_is_stale; then
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git branch --show-current 2>/dev/null > "$GIT_CACHE_FILE"
    else
        echo -n > "$GIT_CACHE_FILE"
    fi
fi

BRANCH=$(cat "$GIT_CACHE_FILE")

[ "$CTX_PCT" -gt 100 ] 2>/dev/null && CTX_PCT=100
CTX_BAR=$(make_bar "$CTX_PCT")

BRANCH_SEGMENT=""
[ -n "$BRANCH" ] && BRANCH_SEGMENT=" $BRANCH ·"

USAGE_SEGMENT=""
if [ -n "$FIVE_H" ] && [ -n "$SEVEN_D" ]; then
    FIVE_H_INT=$(printf '%.0f' "$FIVE_H")
    SEVEN_D_INT=$(printf '%.0f' "$SEVEN_D")
    [ "$FIVE_H_INT" -gt 100 ] 2>/dev/null && FIVE_H_INT=100
    [ "$SEVEN_D_INT" -gt 100 ] 2>/dev/null && SEVEN_D_INT=100
    FIVE_BAR=$(make_bar "$FIVE_H_INT")
    SEVEN_BAR=$(make_bar "$SEVEN_D_INT")
    USAGE_SEGMENT=" · 󰪢 $FIVE_BAR ${FIVE_H_INT}% · 󰨳 $SEVEN_BAR ${SEVEN_D_INT}%"
fi

echo "${BRANCH_SEGMENT} ⛁ $CTX_BAR ${CTX_PCT}%${USAGE_SEGMENT}"
