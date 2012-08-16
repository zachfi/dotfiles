#! /bin/bash


# Get rbenv up on a new system
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
rbenv install 1.9.3-p194

