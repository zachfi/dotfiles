
include osx

class osx {
  Package { provider => macports }
  $packages = [
    "colordiff",
    "nmap",
    "htop",
    "gpg-agent",
    "keychain",
  ]
  package { $packages: }

}

