#! /bin/bash

# Setup pyenv for local pythons on a new system

pyenv_url="https://github.com/yyuu/pyenv.git"

# Clone the pyenv source
git clone $pyenv_url ~/.pyenv

default_ver="3.4.3"

# install the default version
~/.pyenv/bin/pyenv install $default_ver
~/.pyenv/bin/pyenv global $default_ver

