alias reload!='. ~/.zshrc'

local uname=$(uname)

if [[ $uname == "Linux" ]]; then
  alias ls="ls -sh --color=auto"
  alias grep='grep --color=auto'
elif [[ $uname == "OpenBSD" ]]; then
  alias ls="ls -F"
else # FreeBSD, OSX, etc
  alias ls="ls -GF"
  alias grep='grep --color=auto'
fi

alias ll="ls -lFhp"
alias lla='ll -A'
alias lls='ll -Sr'
alias llt='ll -Tt'
alias lld='ll -d'
alias llf='ll -f'
alias ping='ping -c 2'
alias df="df -h"
alias diff="colordiff"
alias newpass="LANG=C tr -cd '[:alnum:]' < /dev/random | head -c 30"
alias vi="vim"
if [[ -x /opt/local/bin/vim ]]; then
  alias vim="/opt/local/bin/vim"
fi
alias v="mvim -c 'au VimLeave * maca hide:'"

