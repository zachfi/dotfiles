## Setup environment
#TMOUT=3600
export EDITOR="lvim"
export PAGER="less -R"
export HISTFILE=$HOME/.histfile
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
# remove / from wordchars, so ^W will go back to the last / for example
export WORDCHARS="${WORDCHARS:s#/#}"
#FONT="terminus"
#
export LANG=en_US.UTF-8

[[ -d /usr/local/bin ]] && PATH+=":/usr/local/bin"
[[ -d /opt/local/bin ]] && PATH+=":/opt/local/bin"
[[ -d /usr/local/sbin ]] && PATH+=":/usr/local/sbin"
[[ -d /opt/local/sbin ]] && PATH+=":/opt/local/sbin"
[[ -d ~/bin ]] && PATH+=":$HOME/bin"
[[ -d ~/local/bin ]] && PATH+=":$HOME/local/bin"
[[ -d ~/shadow/bin ]] && PATH+=":$HOME/shadow/bin"

# use coreutils from macports if available
[[ -d /opt/local/libexec/gnubin ]] && PATH+=":/opt/local/libexec/gnubin"
# Source coreutils aliases from brew if it exists
[[ -f /usr/local/Cellar/coreutils/8.12/aliases ]] && source /usr/local/Cellar/coreutils/8.12/aliases

# All the pretty colors
$(which dircolors > /dev/null) && [[ -f ~/.dircolors ]] && eval `dircolors ~/.dircolors`


# Keychain
# keychain -k mine
[[ $UID -ne 0 ]] && eval `keychain --nolock --ignore-missing -q --eval --agents ssh,gpg --timeout 720 id_rsa id_ed25519 id_ecdsa`


