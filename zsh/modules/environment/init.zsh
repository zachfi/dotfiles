#
# Shell State
#
setopt NOBEEP             # stop beeping

#
# Job Control
#
setopt LONG_LIST_JOBS     # List jobs in long format
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
unsetopt NOTIFY           # Wait until I am paying attention to tell me job status
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

#
# Termcap
#

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[0;36m'        # begin bold -- cyan
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[0;34m'        # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[0;35m'        # begin underline -- purple
export LESS_TERMCAP_zz=$'\E[0m'           # make 'export' output not now all be colourised.

