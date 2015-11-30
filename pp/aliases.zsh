if [ -x ~/src/puppet/ext/envpuppet ]; then
  if [ -d ~/src/puppet ]; then
    alias puppet="~/src/puppet/ext/envpuppet puppet"
    alias puppet-module="~/src/puppet/ext/envpuppet ~/src/puppet-module-tool/bin/puppet-module"
  fi

  if [ -d ~/src/facter ]; then
    alias facter="~/src/puppet/ext/envpuppet facter"
  fi

  if [ -d ~/src/mcollective ]; then
    alias mco="~/src/puppet/ext/envpuppet /Users/zach/src/marionette-collective/mco"
    alias mco="RUBYLIB=~/src/mcollective/lib ~/src/mcollective/bin/mco"
  fi

  export FACTER_HOMEDIR=$HOME
fi


