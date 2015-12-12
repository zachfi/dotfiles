# Here are the minimal requirements to get the Puppet deployment functional

$gems = [
  'r10k',
  'hiera',
]

package { $gems:
  ensure   => installed,
  provider => gem,
}

