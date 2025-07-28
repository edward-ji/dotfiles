#!/usr/bin/env zsh
# shellcheck shell=bash

# homebrew is a package manager for macOS
if [ "$(arch)" = "arm64" ]; then
    BREW_PATH="/opt/homebrew/bin/brew"
elif [ "$(arch)" = "i386" ]; then
    BREW_PATH="/usr/local/bin/brew"
fi
if [[ -f $BREW_PATH && -x $BREW_PATH ]]; then
    eval "$($BREW_PATH shellenv)"
fi

# homebrew auto-complete
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
