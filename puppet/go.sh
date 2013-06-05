#! /bin/bash

MANIFEST=${HOME}/dotfiles/puppet/init.pp
MODULEPATH=~/dotfiles/puppet/modules:~/Code/modules/other

puppet apply --modulepath $MODULEPATH -v $MANIFEST $@
