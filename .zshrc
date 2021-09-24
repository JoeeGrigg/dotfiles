# Prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_RED=$'\e[0;31m'
COLOR_CYAN=$'\e[0;36m'
COLOR_WHITE=$'\e[0m'
setopt PROMPT_SUBST
export PROMPT='${COLOR_RED}[%c]${COLOR_CYAN}$(parse_git_branch)→ ${COLOR_WHITE}'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Variables
export EDITOR="nvim"

# Functions
mkcdir(){ mkdir -p -- "$1" && cd -P -- "$1"; }

# Aliases
alias ls="ls -a1G"
