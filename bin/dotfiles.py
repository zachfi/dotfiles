import os
from subprocess import call
import logging
from shutil import copyfile


class Dotfiles():
    def __init__(self, dotfilesRoot):
        self.dotfilesRoot = dotfilesRoot
        self.homeDir = os.environ['HOME']
        self.logger = logging.getLogger('[dotfiles]')

        self.ensureRuby()
        self.ensureHomebrew()
        self.ensurePuppet()
        self.ensurePython()

    def ensureRuby(self):
        if not os.path.isdir('{0}/.rbenv'.format(self.homeDir)):
            self.logger.info('Setting up Ruby...')
            call(['{}/ruby/install.sh'.format(self.dotfilesRoot)])

    def ensurePython(self):
        if not os.path.isdir('{0}/.pyenv'.format(self.homeDir)):
            self.logger.info('Setting up Python...')
            call(['{}/python/install.sh'.format(self.dotfilesRoot)])

    def ensureHomebrew(self):
        if os.uname()[0] == 'Darwin':
            if not os.path.isfile('/usr/local/bin/brew'):
                self.logger.info('Installing homebrew...')
                call(['{}/osx/homebrew/init.sh'.format(self.dotfilesRoot)])
        else:
            self.logger.info('Skipping homebrew on non-Darwin system {}'.format(os.uname()[0]))

    def ensurePuppet(self):
        self.logger.info('begin shadow Puppet')

        sources = {}
        sources['puppet'] = 'git://github.com/puppetlabs/puppet.git'
        sources['facter'] = 'git://github.com/puppetlabs/facter.git'

        for k in sources:
            dest = os.environ['HOME'] + "/src/" + k
            if not os.path.exists(dest):
                call(['git', 'clone', sources[k], dest])

        call(['{}/puppet/go.sh'.format(self.dotfilesRoot)])

