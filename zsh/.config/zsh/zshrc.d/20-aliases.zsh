#!/usr/bin/env zsh
# shellcheck shell=bash

# ls aliases
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -hl'
alias lla='ls -hla'

# mkdir aliases
alias mkdir='mkdir -pv'

# grep alias auto color
alias grep='grep --color'

# suppress stdout and stderr
alias -g NUL='&> /dev/null'
alias -g OUTNUL='> /dev/null'
alias -g ERRNUL='2> /dev/null'

# eza is a fork of unmaintained exa
alias exa='eza'
