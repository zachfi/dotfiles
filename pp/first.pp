# Here are the minimal requirements to get the Puppet deployment functional

$gems = [
  'r10k',
]

package { $gems:
  ensure   => installed,
  provider => gem,
}

