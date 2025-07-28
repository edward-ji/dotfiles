for zsh_file in "$ZDOTDIR"/zshrc.d/*.zsh; do
    source "$zsh_file"
done
