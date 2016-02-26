class zach::darwin {
  # ----------
  # Brews
  $brews = [
    'tmux',
    'reattach-to-user-namespace',
    'gpgme',
    'gnupg2',
    'gnupg',
    'gpg-agent',
    'keychain',
    'mutt',
    'offline-imap',
    'notmuch',
    'msmtp',
    'mobile-shell',
    'pinentry',
    'rbenv',
    'ruby-build',
    'ack',
    'htop',
    'aspell',
    'corkscrew',
    'vim',
    'macvim',
    'git',
    'syncthing',
    'rumember',
  ]

  package { $brews:
    ensure   => latest,
    provider => brew,
  }

  file { "${::homedir}/Library/LaunchAgents/homebrew.mxcl.syncthing.plist":
    ensure  => link,
    target  => '/usr/local/opt/syncthing/homebrew.mxcl.syncthing.plist',
    require => Package['syncthing'],
    notify  => Exec['launchctl syncthing'],
  }

  # I'm sure there is a better way
  exec { 'launchctl syncthing':
    command     => '/bin/launchctl load ~/Library/LaunchAgents/homebrew.mxcl.syncthing.plist',
    refreshonly => true,
  }

  # ----------
  # /Applications

  package { "iTerm":
    ensure   => present,
    provider => compressed_app,
    source   => 'https://iterm2.com/downloads/stable/iTerm2-2_1_4.zip',
  }

  package { "Alfred 2":
    ensure   => present,
    provider => compressed_app,
    source   => 'https://cachefly.alfredapp.com/Alfred_2.8.1_425.zip',
  }

  package { "Slack":
    ensure   => present,
    provider => compressed_app,
    source   => 'https://slack-ssb-updates.global.ssl.fastly.net/mac_public_releases/slack-1.1.8.zip',
  }

#package { "ApacheDirectoryStudio":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://apache.mirrors.pair.com//directory/studio/dist/2.0.0.v20130517/ApacheDirectoryStudio-macosx-x86_64-2.0.0.v20130517.dmg',
#}

#package { "BonjourBrowser":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://www.tildesoft.com/files/BonjourBrowser.dmg',
#}


#package { "Cyberduck":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://cyberduck.ch/Cyberduck-4.3.1.zip',
#}

#package { "GoogleChrome":
#    ensure   => present,
#    provider => appdmg,
#    source   => 'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg',
#  }

#package { "SublimeText2":
#  ensure   => present,
#  provider => appdmg,
#  source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg',
#}

#package { "Transmission":
#  ensure   => present,
#  provider => appdmg,
#  source   => 'http://download.transmissionbt.com/files/Transmission-2.77.dmg',
#}

#package { "VLC":
#  ensure   => present,
#  provider => appdmg,
#  source   => 'http://get.videolan.org/vlc/2.0.6/macosx/vlc-2.0.6.dmg',
#}

}
