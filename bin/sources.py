#! /usr/bin/env python

import os
import subprocess

def setup():
    sources = {}
    sources['puppet'] = 'git://github.com/puppetlabs/puppet.git'
    sources['facter'] = 'git://github.com/puppetlabs/facter.git'

    for k in sources:
        dest = os.environ['HOME'] + "/src/" + k
        if not os.path.exists(dest):
            subprocess.call(['git', 'clone', sources[k], dest])

if __name__ == "__main__":
    setup()
