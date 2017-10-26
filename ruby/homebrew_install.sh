#! /bin/bash

default_ver="2.4.0"

brew install rbenv
brew install ruby-build

rbenv install $default_ver
rbenv global $default_ver
