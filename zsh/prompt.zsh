#! /bin/zsh


function lprompt {
  [[ -n $SSH_TTY ]] && local at="%F{magenta}@%f" || local at="%F{250}@%f"
  local user_host="%F{240}%n${at}%F{244}%m%F{cyan}:%f"
  PROMPT=$user_host
  PROMPT+='${vcs_info_msg_1_}'
  PROMPT+="%F{red}%(?.. exit %?)%f"
  PROMPT+="
"
  PROMPT+="%F{014}%#%f "

}

precmd () { vcs_info 'prompt' }

RPROMPT='${vcs_info_msg_0_}'
lprompt

