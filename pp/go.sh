#! /bin/bash

SITEPP=${HOME}/dotfiles/pp/site.pp
MODULEPATH=~/dotfiles/pp:~/dotfiles/pp/modules:~/dotfiles:~/Code/modules/other
ENVPUPPET=~/src/puppet/ext/envpuppet

# Ensure r10k is installed
if [ ! -f ~/.rbenv/shims/r10k ]; then
	if [ -x ~/.rbenv/shims/gem ]; then
		/Users/zach/.rbenv/shims/gem install r10k
	fi
fi

# Execute the r10k deployment
. ~/dotfiles/pp/r10k.zsh
~/.rbenv/shims/r10k puppetfile install -v

if [ -x $ENVPUPPET ]; then
	#$ENVPUPPET puppet config set modulepath $MODULEPATH
	$ENVPUPPET puppet apply --modulepath $MODULEPATH -v -e 'include zach' $@
fi



