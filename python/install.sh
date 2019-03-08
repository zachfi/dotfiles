#! /bin/bash

# Install pyenv on a new system or updates it on an existing system.

set -e

default_ver="3.6.6"
pyenv_url="https://github.com/yyuu/pyenv.git"
pyenv_d="${HOME}/.pyenv"

if [ -d "${pyenv_d}" ]; then
    pushd $pyenv_d
    git pull
    popd
else
    git clone $pyenv_url $pyenv_d
fi


# install the default version
$pyenv_d/bin/pyenv install $default_ver
$pyenv_d/bin/pyenv global $default_ver

