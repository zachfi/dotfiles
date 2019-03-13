import os
from subprocess import call
import logging
import fnmatch
from jinja2 import Template
import difflib


class Dotfiles():
    def __init__(self, dotfilesRoot):
        self.dotfilesRoot = dotfilesRoot
        self.homeDir = os.environ['HOME']

        logging.basicConfig(level=logging.DEBUG)

        self.logger = logging.getLogger('dotfiles')

    def setup(self):
        """ Perform the symlinks and template rendering """
        self.performSymlinks()
        self.renderTemplates()

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
            self.logger.info(
                'Skipping homebrew on non-Darwin system {}'.format(os.uname()[0]))

    def link(self, source, dest):
        try:
            if not os.path.exists(dest):
                print("linking " + source + " to " + dest)
                os.symlink(source,dest)
        except:
            print("fail")

    def find(self, pattern):
        for root, dirs, files in os.walk(self.dotfilesRoot):
            for name in files:
                if fnmatch.fnmatch(name, pattern):
                    yield os.path.join(root, name)
            for name in dirs:
                if fnmatch.fnmatch(name, pattern):
                    yield os.path.join(root, name)

    def performSymlinks(self):
        self.logger.info('Finding linkables...')
        for x in self.find('*.symlink'):
            self.logger.debug("Found %s" % x)
            self.dotlink(x)

    def renderTemplates(self):
        self.logger.info('Finding templates...')
        for x in self.find('*.symlink.j2'):
            self.logger.debug("Found %s" % x)
            self.dotfilerender(x)

    def dotlink(self, source):
        """ Symlink a source file to the root name, stripping off .symlink """
        dest = os.environ['HOME'] + "/." + os.path.basename(source.split('.symlink')[0])
        if os.path.exists(dest):
            current_target = os.path.realpath(dest)
            if current_target != source:
                self.link(source, dest)
        else:
            self.link(source,dest)

    def dotfilerender(self, source):
        """ Render a template file and write it to the homedir, stripping off .symlink.j2 """

        data = {'osfamily': os.uname()[0]}
        dest = os.environ['HOME'] + "/." + os.path.basename(source.split('.symlink.j2')[0])
        with open(source) as f:
            t = Template(f.read())

        content = t.render(data=data)

        if os.path.isfile(dest):
            with open(dest) as f:
                current_content = f.read()

            diff = difflib.unified_diff(current_content.splitlines(1), content.splitlines(1))
            diffoutput = ''.join(diff)
            if len(diffoutput) > 0:
                self.logger.info("Updating file %s:" % dest)
                print(diffoutput)
                with open(dest, 'w') as f:
                    f.write(content)
        else:
            self.logger.info("Creating file %s:" % dest)
            with open(dest, 'w') as f:
                f.write(content)

