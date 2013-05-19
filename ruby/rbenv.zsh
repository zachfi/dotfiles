
if [ -d $HOME/.rbenv/bin ]; then
  PATH="$HOME/.rbenv/bin:$PATH"
fi

/usr/bin/which -s rbenv
if [ $? = 0 ]; then
  eval "$(rbenv init -)"
  source ~/.rbenv/completions/rbenv.zsh
fi
