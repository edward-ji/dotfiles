#!/usr/bin/env zsh
# shellcheck shell=bash disable=SC2206

bindkey -v
export KEYTIMEOUT=1

bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[._-/]=** r:|=**' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename "${HOME}/.zshrc"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

fpath=(~/.zfunc "$fpath")
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
