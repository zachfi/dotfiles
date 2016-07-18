alias reload!='. ~/.zshrc'

local uname=$(uname)

if [[ "$OSTYPE" == linux* ]]; then
  alias ls="ls -sh --color=auto"
  alias grep='grep --color=auto'
elif [[ "$OSTYPE" == openbsd* ]]; then
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


alias df='df -kh'
alias du='du -kh'

alias http-serve='python3 -m http.server'

# Used by 'ls'
export LSCOLORS="exGxcxdxcxegedabagacAe"
export CLICOLOR=true

# Imported by ZSH for expansion
export LS_COLORS="di=34:ln=31;41:so=31;41:pi=31;41:ex=31;41:bd=31;41:cd=31;41:su=31;41:sg=31;41:tw=31;41:ow=31;41:"

#fpath=($ZSH/zsh/functions $fpath)


#zle -N newtab

alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

