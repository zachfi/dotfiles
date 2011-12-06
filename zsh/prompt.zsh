#! /bin/zsh


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

function lprompt {
  [[ -n $SSH_TTY ]] && local at="%F{magenta}@%f" || local at="%F{250}@%f"
  local user_host="%F{240}%n${at}%F{244}%m%F{cyan}:%f"
  PROMPT=
  PROMPT+="${user_host}"
  PROMPT+='$vcs_info_msg_1_'
  PROMPT+="%F{red}%(?.. exited %?)%f"
  PROMPT+="
"
  PROMPT+="%F{014}%#%f "

}

set_prompt () {

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
  local git='$vcs_info_msg_0_'
  RPROMPT=
  RPROMPT+="${git}"
}

lprompt
rprompt


