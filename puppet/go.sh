#! /bin/bash

MANIFEST=${HOME}/dotfiles/puppet/init.pp
SITEPP=${HOME}/dotfiles/puppet/site.pp
MODULEPATH=~/dotfiles/puppet:~/dotfiles/puppet/modules:~/dotfiles:~/Code/modules/other
ENVPUPPET=~/src/puppet/ext/envpuppet

if [ -x $ENVPUPPET ]; then
	$ENVPUPPET puppet apply --modulepath $MODULEPATH -v $MANIFEST $@

	# R10k
	. ~/dotfiles/puppet/r10k.zsh
	r10k puppetfile install -v

	#$ENVPUPPET puppet config set modulepath $MODULEPATH
	$ENVPUPPET puppet apply --modulepath $MODULEPATH -v $SITEPP $@
fi



