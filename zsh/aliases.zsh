alias reload!='. ~/.zshrc'

[[ `uname` == "Linux" ]] && alias ls="ls -sh --color=auto" || alias ls="ls -GF"

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
alias dots="puppet apply -v ~/dotfiles/initialize.rb" 

alias vh="mvim -c 'au VimLeave * maca hide:'"
# sup
for x in sup sup-add sup-config sup-dump sup-recover-sources sup-sync sup-sync-back sup-tweak-labels; do
  alias ${x}="rvm system exec ${x}"
done

