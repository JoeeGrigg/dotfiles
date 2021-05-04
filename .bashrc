# Base Path
export PATH="~/bin:/usr/local/bin:$PATH"

# Default Editor
export EDITOR="nvim"

# History
HISTSIZE=10000
HISTFILESIZE=10000

# Disable ctrl-s from freezing terminal on Linux
stty -ixon

# Local Bash RC
if test -f ~/.bashrc.local; then
  source ~/.bashrc.local
fi

# Cursor
get_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'; }
export PS1="\[$(tput setaf 1)\][\W]\[$(tput setaf 6)\]\$(get_git_branch)→ \[$(tput sgr0)\]"

# Aliases
alias ls="ls -a1G"

# Functions
mkcdir(){ mkdir -p -- "$1" && cd -P -- "$1"; }

# Software
if test -f ~/.bashrc.software; then
  source ~/.bashrc.software
fi
