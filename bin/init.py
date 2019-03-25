#! /usr/bin/env python

import os

from dotfiles import Dotfiles


def main():
    homedir = os.environ['HOME']
    dotfilesRoot = homedir + '/dotfiles'

    d = Dotfiles(dotfilesRoot)
    d.setup()


if __name__ == "__main__":
    main()
