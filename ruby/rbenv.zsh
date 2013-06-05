#

# Detect if rbenv has been installed to the homedir
if [ -d $HOME/.rbenv ]; then
  # Append to the path
  if [ -d $HOME/.rbenv/bin ]; then
    PATH="$HOME/.rbenv/bin:$PATH"
  fi

  # Load the completions from home
  /usr/bin/which -s rbenv
  if [ $? = 0 ]; then
    eval "$(rbenv init -)"
    source ~/.rbenv/completions/rbenv.zsh
  fi
fi

