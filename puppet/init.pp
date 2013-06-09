
# ----------
# RubyGems
$gems = [
  'puppet',
  'facter',
  'r10k',
  'weigh',
  'rumember',
  'backup',
  'bundler',
]

package { $gems:
  ensure   => installed,
  provider => gem,
}


# ----------
# Brews
$brews = [
  'tmux',
  'mutt',
  'offline-imap',
  'notmuch',
  'msmtp',
  'keychain',
  'gnupg2',
  'gnupg',
  'mobile-shell',
  'pinentry',
  'rbenv',
  'ruby-build',
  'ack',
  'htop-osx',
  'aspell',
  'corkscrew',
  'gpg-agent',
  'vim',
  'macvim',
]

package { $brews:
  ensure   => installed,
  provider => brew,
}


# ----------
# ~/Applications

#package { "iTerm2":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://www.iterm2.com/downloads/stable/iTerm2_v1_0_0.zip',
#}

#package { "Alfred":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://cachefly.alfredapp.com/Alfred_2.0.4_199.zip',
#}

#package { "ApacheDirectoryStudio":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://apache.mirrors.pair.com//directory/studio/dist/2.0.0.v20130517/ApacheDirectoryStudio-macosx-x86_64-2.0.0.v20130517.dmg',
#}

#package { "BittorrentSync":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://btsync.s3-website-us-east-1.amazonaws.com/BTSync.dmg',
#}

#package { "BonjourBrowser":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://www.tildesoft.com/files/BonjourBrowser.dmg',
#}

#package { "Caffeine":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://lightheadsw.com/files/releases/com.lightheadsw.Caffeine/Caffeine1.1.1.zip',
#}

#package { "Cyberduck":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://cyberduck.ch/Cyberduck-4.3.1.zip',
#}

#package { "GoogleChrome":
#  ensure   => present,
#  provider => appdmg,
#  source   => 'https://dl.google.com/chrome/mac/stable/GoogleChrome.dmg',
#}

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

#package { "YoruFukurou":
#  ensure   => present,
#  provider => compressed_app,
#  source   => 'http://aki-null.net/yf/YoruFukurou_SL.zip',
#}

