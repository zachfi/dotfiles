#! /bin/bash

# Install pyenv on a new system or updates it on an existing system.

set -e

default_ver="3.9.9"
pyenv_url="https://github.com/yyuu/pyenv.git"
pyenv_d="${HOME}/.pyenv"

if [ -d "${pyenv_d}" ]; then
    pushd $pyenv_d
    git pull
    popd
else
    git clone $pyenv_url $pyenv_d
fi

# if OSX
# CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
# LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
# PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2 \
# pyenv install -v 3.6.0



# install the default version
$pyenv_d/bin/pyenv install $default_ver
$pyenv_d/bin/pyenv global $default_ver
