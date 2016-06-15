#if [ -n $SSH_CONNECTION ]; then
#  export PS1='%m:%3~$(git_info_for_prompt)%# '
#else
#  export PS1='%3~$(git_info_for_prompt)%# '
#fi

# Used by 'ls'
export LSCOLORS="exGxcxdxcxegedabagacAe"
export CLICOLOR=true

# Imported by ZSH for expansion
export LS_COLORS="di=34:ln=31;41:so=31;41:pi=31;41:ex=31;41:bd=31;41:cd=31;41:su=31;41:sg=31;41:tw=31;41:ow=31;41:"

#fpath=($ZSH/zsh/functions $fpath)

autoload -U $ZSH/zsh/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#zle -N newtab

