if [ -d $HOME/.pyenv ]; then
  # Append to the path
  if [ -d $HOME/.pyenv/bin ]; then
    PATH="$HOME/.pyenv/bin:$PATH"
  fi
fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
