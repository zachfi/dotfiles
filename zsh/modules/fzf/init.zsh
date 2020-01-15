UNAME=$(uname)

if [ "${UNAME}" = "Darwin" ]; then
  BINDINGS=/usr/local/opt/fzf/shell/key-bindings.zsh
  COMPLETION=/usr/local/opt/fzf/shell/completion.zsh
elif [ "${UNAME}" = "FreeBSD" ]; then
  BINDINGS=/usr/local/share/examples/fzf/shell/key-bindings.zsh
  COMPLETION=/usr/local/share/examples/fzf/shell/completion.zsh
else # Assume Archlinux
  BINDINGS=/usr/share/fzf/key-bindings.zsh
  COMPLETION=/usr/share/fzf/completion.zsh
fi

if [ -s "${BINDINGS}" ]; then
  source $BINDINGS
fi

if [ -s "${COMPLETION}" ]; then
  source $COMPLETION
fi

export FZF_DEFAULT_OPTS='--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168'
