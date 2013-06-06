#! /bin/bash

MANIFEST=${HOME}/dotfiles/puppet/init.pp
MODULEPATH=~/dotfiles/puppet/modules:~/dotfiles:~/Code/modules/other

puppet apply --modulepath $MODULEPATH -v $MANIFEST $@
