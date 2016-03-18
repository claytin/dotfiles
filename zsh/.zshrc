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

# dircolors
eval $(dircolors ~/.dircolors)

source $HOME/.zaliases
source $HOME/.zfunctions
source $HOME/.zstyles

[[ -f $HOME/.zlaptop ]] && source $HOME/.zlaptop

# helps with colors on prompt
autoload -U colors
colors

# vi mode
bindkey -v
export KEYTIMEOUT=1

# prompt
SCHAR="\u03bb"
PROMPT="%F{magenta}$(echo -ne $SCHAR)%f "

export PATH=$PATH:~/.rakudobrew/bin
