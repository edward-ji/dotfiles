# set XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# set PATH for user-installed programs
export PATH="$HOME/.local/bin:$PATH"

# set ZSH dotfiles directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
[[ -d "$XDG_STATE_HOME"/zsh ]] || mkdir -p "$XDG_STATE_HOME"/zsh
[[ -d "$XDG_CACHE_HOME"/zsh ]] || mkdir -p "$XDG_CACHE_HOME"/zsh

# change default command line editor to vim
export EDITOR=nvim
export VISUAL=nvim

# cargo generated
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# do not show any hints about changing brew behaviour with environment variables
export HOMEBREW_NO_ENV_HINTS=1
# dump without VSCode (and forks/variants) extensions and Go packages
export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1
export HOMEBREW_BUNDLE_DUMP_NO_GO=1

# do not change the prompt when activating a python virtual environment
export VIRTUAL_ENV_DISABLE_PROMPT=1

# disable MacOS save/restore shell state feature
export SHELL_SESSIONS_DISABLE=1
