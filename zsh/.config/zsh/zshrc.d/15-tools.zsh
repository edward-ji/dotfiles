# fzf is a general-purpose command-line fuzzy finder
if type fzf &> /dev/null; then
    FZF_ALT_C_COMMAND= source <(fzf --zsh)
    zle -N fzf-cd-widget
    bindkey '^G' fzf-cd-widget
fi

# zoxide is a smarter cd command, inspired by z and autojump (must run after compinit for completions)
if type zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# uv is an extremely fast Python package and project manager
if type uv &> /dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi
if type uvx &> /dev/null; then
    eval "$(uvx --generate-shell-completion zsh)"
fi
