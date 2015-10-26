# ----------
# RubyGems
$gems = [
  'r10k',
  'weigh',
  'rumember',
  'backup',
  'bundler',
  'pushover',
  'colorize',
  'terminal-table',
]

package { $gems:
  ensure   => installed,
  provider => gem,
}


if $::kernel == 'Darwin' {
  include me::darwin
}

file { "${home}/.tmux.conf":
  owner   => $::id,
  mode    => '0600',
  content => template('me/tmux.conf.erb'),
}

