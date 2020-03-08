#! /bin/bash

# Installs rbenv on a new system, or updates it on an existing system.

set -e

default_ver="2.7.0"
rbenv_url="https://github.com/sstephenson/rbenv.git"
rbenv_build_url="https://github.com/sstephenson/ruby-build.git"
rbenv_d="${HOME}/.rbenv"

if [ -d "${rbenv_d}" ]; then
    pushd $rbenv_d
    git pull
    popd
else
    git clone $rbenv_url $rbenv_d
fi

# Create prepare the build plugin
if [ ! -d "${rbenv_d}/plugins" ]; then
    mkdir -p ~/.rbenv/plugins
fi

if [ -d "${rbenv_d}/plugins/ruby-build" ]; then
    pushd $rbenv_d/plugins/ruby-build
    git pull
    popd
else
    git clone $rbenv_build_url $rbenv_d/plugins/ruby-build
fi

# install the default version
$rbenv_d/bin/rbenv install $default_ver
$rbenv_d/bin/rbenv global $default_ver

