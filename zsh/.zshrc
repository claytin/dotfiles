# histroy
HISTSIZE=5000
HISTFILE="${HOME}/.zhistory"
SAVEHIST=$HISTSIZE

setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space

# completion
autoload -U compinit
compinit

# correction
setopt correctall

# advanced prompt support
autoload -U promptinit
promptinit

# auto cd into dirs
setopt autocd

# extend glob
setopt extendedglob

source $HOME/.zaliases
source $HOME/.zfunctions
source $HOME/.zstyles

# helps with colors on prompt
autoload -U colors
colors

# needed for colorfull termite
eval $(dircolors ~/.dircolors)

bindkey -v # vi mode

# prompt

local FAIL='!'
local TISJ='+'

local SUFFIX=" %F{magenta}%#%f"

function my_prompt {
     local pstr

     pstr="%F{8}${1}%f"

     [[ $CMDRV -ne 0 ]] && pstr="${pstr} %F{1}${FAIL}%f" # melhorar

     [[ $(jobs -l | wc -l) -gt 0 ]] && pstr="${pstr} %F{3}${TISJ}%f"

     echo "${pstr}"
}

function get_cmdrv { CMDRV=$? }

function zle-line-init zle-keymap-select {
     local KM="${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}"

     PROMPT="$(my_prompt $KM)${SUFFIX} "

     zle reset-prompt
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd get_cmdrv

zle -N zle-line-init     # Attach widgets
zle -N zle-keymap-select # ...

export KEYTIMEOUT=1

RPROMPT="%F{15}%3~%f"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:~/.rakudobrew/bin
