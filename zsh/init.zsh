
# site local variables
export ZSH=~/dotfiles/zsh
export PROJECTS=~/Code
export WORK=~/NewRelic
export ORGS=~/Org

# load requirements
autoload -U colors; colors
zmodload -i zsh/complist
autoload -U edit-command-line
zle -N edit-command-line

# set the function path
fpath=($ZSH/functions $fpath)

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit; compinit
autoload -U $ZSH/functions/*(:t)

# Setup the prompt
autoload -U promptinit; promptinit
prompt zleslie

if [ -s ~/.localrc ]; then
  source ~/.localrc
fi

source ~/dotfiles/zsh/bindkey.zsh
source ~/dotfiles/zsh/env.zsh
source ~/dotfiles/zsh/functions.zsh
source ~/dotfiles/zsh/options.zsh

function dotmodload {
  local -a dotmodules
  local dotmodule

  dotmodules=("$argv[@]")

  for dotmodule in "$dotmodules[@]"; do
    if [[ -d $ZSH/modules/$dotmodule/functions ]]; then
      fpath=($ZSH/modules/$dotmodule/functions $fpath)
    fi

    if [[ -s $ZSH/modules/$dotmodule/init.zsh ]]; then
      source "${ZSH}/modules/${dotmodule}/init.zsh"
    fi
  done
}

zstyle -a ':zdotfiles:load' dotmods 'dotfilemodules'
dotmodload "$dotfilemodules[@]"
unset dotfilemodules
