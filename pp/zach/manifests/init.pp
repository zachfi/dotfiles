class zach {

  file { "${::homedir}/.tmux.conf":
    owner   => $::id,
    mode    => '0600',
    content => template('zach/tmux.conf.erb')
  }

  file { "${::homedir}/Code":
    ensure => directory,
    owner  => $::id,
    mode   => '0700',
  }

  $pips = [
    'attic',
  ]

  package { $pips:
    ensure   => installed,
    provider => pip,
  }
}
