#! /bin/sh

if test ! $(which brew)
then
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

brew update

exit 0
