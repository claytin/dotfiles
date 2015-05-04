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

bindkey -v          # "force" vi line edit mode as default
export KEYTIMEOUT=1 # reduces delay between modes

# prompt
local RA=''    # \ue0b0
local LA=''    # \ue0b2

local FAIL='✘'  # \u2718
local TISJ='+'

local SUFFIX="%K{black} %F{magenta}%#%f %k%F{black}${RA}%f"

prompt_state() {
     local pstr
     pstr=""

     case $CMDRV in
          ( 0 | 148 )
               ;;
          (*) pstr="%K{8} %F{red}${FAIL}%f %k"
               ;;
     esac

     [[ $(jobs -l | wc -l) -gt 0 ]] && pstr="${pstr}%K{8} %F{yellow}${TISJ}%f %k"

     [[ -n "${pstr}" ]] && echo "${pstr}%K{black}%F{8}${RA}%f%k"
}

set_prompt() {
     CMDRV=$?
     PROMPT="$(prompt_state)$SUFFIX "
}

prompt_init() {
     autoload -Uz add-zsh-hook
     add-zsh-hook precmd set_prompt
}

prompt_init
RPROMPT="%F{black}${LA}%f%K{black} %F{white}%3~%f %k"
