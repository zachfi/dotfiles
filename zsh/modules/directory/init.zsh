# Options for directory handling
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
unsetopt CDABLE_VARS        # stop guessing ~ is at the start of a directory
setopt CHASE_LINKS          # Resolve symbolic links to their true values when changing directory.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt NOMATCH            # Don't print an error when no patch is found
unsetopt CLOBBER            # Safer pipes, preserve existing files with > and >>.
                            # Use >! and >>! to bypass.

