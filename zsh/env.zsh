## Setup environment
#TMOUT=3600
EDITOR="vim"
PAGER="less"
HISTFILE=$HOME/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
GREP_COLOR="4;36"
# remove / from wordchars, so ^W will go back to the last / for example
WORDCHARS="${WORDCHARS:s#/#}"
#FONT="terminus"

# All the pretty colors
[[ -f ~/.dircolors ]] && eval `dircolors ~/.dircolors`

[[ -d /usr/local/bin ]] && PATH+=":/usr/local/bin"
[[ -d /opt/local/bin ]] && PATH+=":/opt/local/bin"

# use coreutils from macports if available
[[ -d /opt/local/libexec/gnubin ]] && PATH+=":/opt/local/libexec/gnubin"
# Source coreutils aliases from brew if it exists
[[ -f /usr/local/Cellar/coreutils/8.12/aliases ]] && source /usr/local/Cellar/coreutils/8.12/aliases

# Keychain
eval `keychain -q --eval --agents ssh,gpg --timeout 120 id_rsa`

