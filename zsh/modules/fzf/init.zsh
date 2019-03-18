if [ -s "/usr/share/fzf/key-bindings.zsh" ]; then
  source /usr/share/fzf/key-bindings.zsh
fi

if [ -s "/usr/share/fzf/key-bindings.zsh" ]; then
  source /usr/share/fzf/key-bindings.zsh
fi

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
