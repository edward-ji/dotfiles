# Prompt end of line mark
PROMPT_EOL_MARK='%F{8}󰌑%f'

setopt PROMPT_SUBST

# Working directory
PROMPT='%B%3~%b '

# Git integration
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:git*' actionformats '%b (%a)'
autoload -Uz vcs_info
precmd_vcs_info() {
    vcs_info
    if [[ "${#vcs_info_msg_0_}" -ge 15 ]]; then
        vcs_info_msg_0_="${vcs_info_msg_0_:0:12}..."
    fi
}
precmd_functions+=( precmd_vcs_info )
PROMPT+='${vcs_info_msg_0_:+" $vcs_info_msg_0_ "}'

# Exit code and superuser integration
PROMPT+='%(?.%F{green}.%F{red})%(!..)%f '

# show hostname
RPROMPT='%F{8}%n@%m%f'
