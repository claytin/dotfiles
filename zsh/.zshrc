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
local RA=''    # \ue0b0
local LA=''    # \ue0b2

local FAIL='✘'  # \u2718
local TISJ='+'

# local SUFFIX="%K{black} %F{magenta}%#%f %k%F{black}${RA}%f"
local SUFFIX="%F{magenta}%#%f"

function my_prompt {
     local pstr

     # pstr="%K{8} %F{white}${1}%f %k"
     pstr="%F{8}${1}%f "

     # [[ $CMDRV -ne 0 ]] && pstr="${pstr}%K{8} %F{red}${FAIL}%f %k" # melhorar
     [[ $CMDRV -ne 0 ]] && pstr="${pstr}%K{8} %F{red}${FAIL}%f %k" # melhorar

     [[ $(jobs -l | wc -l) -gt 0 ]] && pstr="${pstr}%K{8} %F{yellow}${TISJ}%f %k"

     [[ -n "${pstr}" ]] && echo "${pstr}%K{black}%F{8}${RA}%f%k"
}

function get_cmdrv { CMDRV=$? }

function zle-line-init zle-keymap-select {
     local KM="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"

     PROMPT="[$(my_prompt $KM)]─ ${SUFFIX} "

     zle reset-prompt
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd get_cmdrv

zle -N zle-line-init     # Attach widgets
zle -N zle-keymap-select # ...

export KEYTIMEOUT=1

# RPROMPT="%F{black}${LA}%f%K{black} %F{white}%3~%f %k"
RPROMPT="%3~"
