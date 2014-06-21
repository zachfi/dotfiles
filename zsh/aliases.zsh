alias reload!='. ~/.zshrc'

uname="$(uname)"

if [[ $uname == "Linux" ]]; then
  alias ls="ls -sh --color=auto"
elif [[ $uname == "OpenBSD" ]]; then
  alias ls="ls -F"
else # FreeBSD, OSX, etc
  alias ls="ls -GF"
fi

alias ll="ls -lFhp"
alias lla='ll -A'
alias lls='ll -Sr'
alias llt='ll -Tt'
alias lld='ll -d'
alias llf='ll -f'
alias grep='grep --color=auto'
alias ping='ping -c 2'
alias df="df -h"
alias diff="colordiff"
alias sudo="sudo HOME=${HOME}"
alias newpass="LANG=C tr -cd '[:alnum:]' < /dev/random | head -c 20"
alias vi="vim"
[[ -x /opt/local/bin/vim ]] && alias vim="/opt/local/bin/vim"
alias v="mvim -c 'au VimLeave * maca hide:'"

alias we="weigh"

