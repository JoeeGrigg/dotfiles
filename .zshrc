# Prompt
eval "$(oh-my-posh --init --shell zsh --config '~/.oh-my-posh.json')"

# Variables
export EDITOR="nvim"
bindkey -e # Fix weird zsh thing where setting the editor stops ctrl+r working in tmux

# Functions
mkcdir(){ mkdir -p -- "$1" && cd -P -- "$1"; }

# Aliases
alias ls="ls -a1G"

# Navigation
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
