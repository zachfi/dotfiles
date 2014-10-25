#! /usr/bin/env python

import symlinks
import sources
import os
from subprocess import call
from shutil import copyfile

def ensureRuby():
    homedir = os.environ['HOME']
    if not os.path.isdir('%s/.rbenv' % homedir):
        call(['%s/dotfiles/ruby/install.sh' % homedir])

def ensureHomebrew():
    homedir = os.environ['HOME']
    if not os.path.isdir('/usr/local'):
        call(['%s/dotfiles/osx/homebrew/init.sh' % homedir])


def applyPuppet(manifest):
    homedir = os.environ['HOME']
    call(['%s/bin/envpuppet' % homedir, 'puppet','apply','-v',manifest])

def ensurePuppet():
    homedir = os.environ['HOME']

    source = '%s/src/puppet/ext/envpuppet' % homedir
    dest = '%s/bin/envpuppet' % homedir
    if not os.path.isfile(dest):
        print('copying %s' % source + 'to %s' % dest)
        copyfile(source,dest)
        os.chmod(dest,0700)
        call(['/Users/zach/.rbenv/shims/gem', 'install','CFPropertyList'])
    call(['%s/dotfiles/puppet/go.sh' % homedir])

def main():
    symlinks.setup()
    sources.setup()
    ensureRuby()
    ensureHomebrew()
    ensurePuppet()

main()
