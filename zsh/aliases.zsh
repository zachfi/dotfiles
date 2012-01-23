alias reload!='. ~/.zshrc'

[[ `uname` == "Linux" ]] && alias ls="ls -sh --color=auto" || alias ls="ls -GF"

alias ll="ls -lFshp"
alias lla='ls -lFah'
alias lls='ls -lFth'
alias llr='ls -lFthr'
alias lld='ls -lFd'
alias llx='ls -lFsxh'
alias grep='grep --color=auto'
alias ping='ping -c 2'
alias muppet="mutt -F ~/.muppetrc"
alias df="df -h"
alias diff="colordiff"
alias irc="ssh -t n3kl.cx tmux -L irc attach"
alias sudo="sudo HOME=/home/${HOME}"
alias newpass="LANG=C tr -cd '[:alnum:]' < /dev/random | head -c 20"
alias vi="vim"
alias dots="puppet apply -v ~/dotfiles/initialize.rb" 

alias vh="mvim -c 'au VimLeave * maca hide:'"
# sup
for x in sup sup-add sup-config sup-dump sup-recover-sources sup-sync sup-sync-back sup-tweak-labels; do
  alias ${x}="rvm system exec ${x}"
done

