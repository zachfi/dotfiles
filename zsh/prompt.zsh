#! /bin/zsh

# load in stolen, borrowed, blue, git prompt magic.
# get the status of the working tree
git_prompt_status() {
  OLDIFS=$IFS
  IFS="\000"

  # evil character
  local ec="€"

  #INDEX=( ${(f)"$(git status --porcelain 2> /dev/null)"} )
  #INDEX=( $(git status --porcelain 2> /dev/null) )
  INDEX="${ec}$( git status --porcelain 2> /dev/null | tr "\n" "${ec}" )"
  STATUS=""


  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""
  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}A"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[cyan]%}M"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[cyan]%}D"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[cyan]%}R"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}U"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?"

  [[ "${INDEX[@]}" =~ "${ec}\?\? " ]] && STATUS+="$ZSH_THEME_GIT_PROMPT_UNTRACKED"

  if [[ "${INDEX[@]}" =~ "${ec}A  " ]]
  then
    STATUS+="$ZSH_THEME_GIT_PROMPT_ADDED"
  else
    if [[ "${INDEX[@]}" =~ "${ec}M  " ]]
    then
      STATUS+="$ZSH_THEME_GIT_PROMPT_MODIFIED"
    fi
  fi

  if [[ "${INDEX[@]}" =~ "${ec} M " ]]
  then
    STATUS+="$ZSH_THEME_GIT_PROMPT_MODIFIED"
  else
    if [[ "${INDEX[@]}" =~ "${ec}AM " ]]
    then
      STATUS+="$ZSH_THEME_GIT_PROMPT_MODIFIED"
    else
      if [[ "${INDEX[@]}" =~ "${ec} T " ]]
      then
        STATUS+="$ZSH_THEME_GIT_PROMPT_MODIFIED"
      fi
    fi
  fi

  [[ "${INDEX[@]}" =~ "${ec}R  " ]] && STATUS+="$ZSH_THEME_GIT_PROMPT_RENAMED"
  [[ "${INDEX[@]}" =~ "${ec} D " ]] && STATUS+="$ZSH_THEME_GIT_PROMPT_DELETED"
  [[ "${INDEX[@]}" =~ "${ec}UU " ]] && STATUS+="$ZSH_THEME_GIT_PROMPT_UNMERGED"

  echo $STATUS
}


coloratom() {
  local off=$1 atom=$2
  if [[ $atom[1] == [[:upper:]] ]]; then
    off=$(( $off + 60 ))
  fi
  echo $(( $off + $colorcode[${(L)atom}] ))
}
colorword() {
  local fg=$1 bg=$2 att=$3
  local -a s

  if [ -n "$fg" ]; then
    s+=$(coloratom 30 $fg)
  fi
  if [ -n "$bg" ]; then
    s+=$(coloratom 40 $bg)
  fi
  if [ -n "$att" ]; then
    s+=$attcode[$att]
  fi

  echo "%{"$'\e['${(j:;:)s}m"%}"
}

dir_isgit() {
  pathe=""
  for ((i=0;i<32;i++)); do

    gitdir="${pathe}.git" 
    if [ -d "${gitdir}" ]
    then
      return 0
    fi

    pathe="${pathe}../"
  done

  return -1
}

function lprompt {

  #local bracket_open="${color1}${brackets[1]}%f"
  #local bracket_close="${color1}${brackets[2]}%f"
  #local git='$vcs_info_msg_0_'
  #local cwd="${color1}%B%1~%b%f"
  [[ -n $SSH_TTY ]] && local at="%F{magenta}@%f" || local at="%F{250}@%f"
  local user_host="%F{240}%n${at}%F{244}%m%F{cyan}:%f"

  #PROMPT="%f${user_host}${cwd}%f $ "
  PROMPT=
  #PROMPT+="%F{240}%m%f "
  PROMPT+="${user_host}"
  #PROMPT+="%F{014}%(2~.%~.%/)%f"
  PROMPT+='$vcs_info_msg_1_'
  PROMPT+="%F{red}%(?.. exited %?)%f"
  PROMPT+="
"
  PROMPT+="%F{014}%#%f "

}

precmd () {

  vcs_info 'prompt'
  [[ -t 1 ]] || return
  case $TERM in
    *xterm*|screen*|rxvt*|(dt|k|E)term) print -Pn "\e]0;%n@%m in %d\a"
      ;;
  esac

}

function rprompt {
  #local brackets=$1
  #local color1=$2
  #local color2=$3

  #local bracket_open="${color1}${brackets[1]}%f"
  #local bracket_close="${color1}${brackets[2]}%f"
  #local colon="${color1}:"
  #local at="${color1}@%f"

  #RVM_PROMPT=" %{$fg[yellow]%}${RUBY_VERSION/ruby-/}%{$reset_color%}"

  #[[ -x ~/.rvm/bin/rvm-prompt ]] && ruby_version=$(~/.rvm/bin/rvm-prompt)
  [[ -n $ruby_version ]] && local rvm="${ruby_version}"

  local git='$vcs_info_msg_0_'

  #local user_host="${color2}%n${at}${color2}%m"

  #local vcs_cwd='${${vcs_info_msg_1_%%.}/$HOME/~}'
  #local cwd="${color2}%B%20<..<${vcs_cwd}%<<%b"
  ##local inner="${user_host}${colon}${cwd}"
  #local inner="${git}"

  RPROMPT=
  RPROMPT+="${git}"
  RPROMPT+=" ${rvm}"

  #RPROMPT+=" %F{cyan}%n%f"

  #RPROMPT="%f${bracket_open}${inner}${bracket_close}%f"

  #RPROMPT="${PUPPET_ENV}$RC${RVM_PROMPT}${GIT_PROMPT}${SELINUX}"

}

lprompt
rprompt


