# ZSH Options, like a warm blanket
# Section names taken from the zshoptions(1) manpage

#
# Input/Output
#
unsetopt CLOBBER            # Safer pipes, preserve existing files with > and >>.
                            # Use >! and >>! to bypass.
unsetopt IGNORE_EOF         # ^D logs out
setopt INTERACTIVE_COMMENTS # Allow comments in shell
setopt PRINT_EXIT_VALUE     # alert me if something's failed
setopt SHORT_LOOPS          # allow short forms of loops

#
# Prompt
#
setopt PROMPT_SUBST           # expansion within prompts
setopt TRANSIENT_RPROMPT      # rprompt can go away when needed
unsetopt PROMPT_CR            # don't add \r which overwrites cmd output with no \n

#
# Completion
#
setopt COMPLETE_IN_WORD        # not just at the end
setopt COMPLETE_ALIASES        # when doing completion, also complete aliases
unsetopt AUTO_REMOVE_SLASH     # stop auto removing the slash that the completion did

#
# History
#
setopt INC_APPEND_HISTORY      # write history as soon as its entered
setopt EXTENDED_HISTORY        # write timestamp to the file
setopt HIST_IGNORE_SPACE       # commands beginning with spaces are ommitted from history
setopt HIST_IGNORE_DUPS        # do not write duplicate history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_VERIFY             # when using ! cmds, confirm first

#
# Scripts and Functions
#
setopt LOCAL_OPTIONS           # allow functions to have local options
setopt LOCAL_TRAPS             # allow functions to have local traps

