class zach {
  if $::kernel == 'Darwin' {
    include zach::darwin
  }

  file { "${::homedir}/.tmux.conf":
    owner   => $::id,
    mode    => '0600',
    content => template('zach/tmux.conf.erb')
  }
}
