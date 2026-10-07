bindkey -v
export KEYTIMEOUT=5

# On slow connections, bracketed-paste can time out before the paste-end
# sequence arrives. Swallow it so it isn't run as vi commands.
_swallow-paste-end() {}
zle -N _swallow-paste-end
bindkey -M viins '^[[201~' _swallow-paste-end

bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[._-/]=** r:|=**' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename "${HOME}/.zshrc"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

fpath=(~/.zfunc $fpath)
autoload -Uz compinit
_comp_dump="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
if [[ ! -f "$_comp_dump" || -n ${~_comp_dump}(#qN.mh+24) ]]; then
  compinit -d "$_comp_dump"
else
  compinit -C -d "$_comp_dump"
fi
unset _comp_dump
