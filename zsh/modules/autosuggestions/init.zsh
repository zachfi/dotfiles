UNAME=$(uname)

if [ "${UNAME}" = "Darwin" ]; then
  SUGGFILE=/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else # Assume Archlinux
  SUGGFILE=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -s "${SUGGFILE}" ]; then
  source $SUGGFILE
fi

