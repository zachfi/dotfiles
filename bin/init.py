#! /usr/bin/env python

import symlinks
import sources
import os
from subprocess import call
from shutil import copyfile

from bin.dotfiles import Dotfiles


def applyPuppet(manifest):
    homedir = os.environ['HOME']
    call(['%s/bin/envpuppet' % homedir, 'puppet','apply','-v',manifest])

def main():
    homedir = os.environ['HOME']
    dotfilesRoot = homedir + '/dotfiles'

    symlinks.setup()
    sources.setup()

    d = Dotfiles(dotfilesRoot)

main()
