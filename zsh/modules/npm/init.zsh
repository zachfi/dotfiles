if [[ -d "${HOME}/.npm-global" ]]; then
  NPMPATH=~/.npm-global
  export NPM_CONFIG_PREFIX=$NPMPATH
  export PATH=$PATH:$NPMPATH
fi
