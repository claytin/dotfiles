#!/bin/bash

# Colors
# \001 and \002 are special values, they replace \[ and \] outside of PS1
# assignment context
YELLOW="\001$(tput bold)$(tput setaf 3)\002"
BLUE="\001$(tput bold)$(tput setaf 4)\002"
MAGENTA="\001$(tput setaf 5)\002"
CYAN="\001$(tput setaf 6)\002"
RESET="\001$(tput sgr0)\002"

FANCY_PROMPT=$YELLOW$(~/.z_prompt --jobs)$RESET

VCS_STRING=$(~/.z_prompt --vcs)
if [ -n "$VCS_STRING" ]; then
    # VCS_SPLITS, where
    # VCS_SPLITS[0] is the VCS tool;
    # VCS_SPLITS[1] is the repo;
    # VCS_SPLITS[2] is a decorator for "at"
    # VCS_SPLITS[3] is the branch and its status indicator
    VCS_SPLITS=(${VCS_STRING//:/ })
    
    FANCY_PROMPT=$FANCY_PROMPT' '$MAGENTA${VCS_SPLITS[0]}$RESET
    FANCY_PROMPT=$FANCY_PROMPT' '$BLUE${VCS_SPLITS[1]}$RESET
    FANCY_PROMPT=$FANCY_PROMPT' '${VCS_SPLITS[2]}
    FANCY_PROMPT=$FANCY_PROMPT' '$CYAN${VCS_SPLITS[3]}$RESET
fi

echo -ne "$FANCY_PROMPT |> "
