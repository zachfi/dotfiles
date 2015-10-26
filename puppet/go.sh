#! /bin/bash

MANIFEST=${HOME}/dotfiles/puppet/init.pp
MODULEPATH=~/dotfiles/puppet/modules:~/dotfiles:~/Code/modules/other

export FACTER_HOME=${HOME}

puppet apply --modulepath $MODULEPATH -v $MANIFEST --show_diff $@
