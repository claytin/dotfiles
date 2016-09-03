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

zle -N zle-line-init
zle -N zle-keymap-select

function zle-line-init zle-keymap-select {
     PROMPT="$(prologue)"$'\n'"$(vcs_info)$(cst_pc)" # why zsh

     zle reset-prompt
}

PROMPT="%F{green}❭❭%f " # there is some delay when using %{%}, so ...

# Perl6
PATH=$PATH:/opt/rakudo-star-2016.07/bin
PATH=$PATH:/opt/rakudo-star-2016.07/share/perl6/site/bin:/bin

# APL
PATH=$PATH:/opt/apl-1.6/bin

# rtorrent magnet
export PATH=$PATH:/opt/magnet
