#!/usr/bin/env zsh
# shellcheck shell=bash disable=SC2034,SC2016,SC2154

# Prompt end of line mark
PROMPT_EOL_MARK='%F{8}󰌑%f'

##########
# Prompt #
##########
setopt PROMPT_SUBST

# Working directory
PROMPT='%B%3~%b '

# Python venv integration
PROMPT+='${VIRTUAL_ENV_PROMPT:+󰌠 ${VIRTUAL_ENV_PROMPT% } }'

# Jenv integration
precmd_jenv_info() {
    if (( $+commands[jenv] )); then
        jenv_info="$(jenv version-name)"
        if [[ "${jenv_info}" = system ]]; then
            jenv_info=
        fi
    fi
}
precmd_functions+=( precmd_jenv_info )
PROMPT+='${jenv_info:+"󰬷 $jenv_info "}'

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

################
# Right Prompt #
################

# show hostname
RPROMPT='%F{8}%n@%m%f'
