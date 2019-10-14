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

# helps with colors on prompt
autoload -U colors
colors

# vi mode
bindkey -v
export KEYTIMEOUT=1

zle -N zle-line-init
zle -N zle-keymap-select

# prompt setup
function zle-line-init zle-keymap-select {
     PROMPT="$(vcs_info)"
     PROMPT="$PROMPT$(prompt_stats)"

     RPROMPT="$(format_path) "
     zle reset-prompt
}

PROMPT="%F{green}%f " # there is some delay when using %{%}, so ...
RPROMPT="$(echo "%{\e[37m%}%{\e[4m%}")"

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"

# PATH setup
for f in ~/.path-append/*; do
    source $f
done

export $PATH

# neovim setup
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm

export EDITOR="nvim"

# base16-shell
BASE16_SHELL=$XDG_CONFIG_HOME/base16-shell/

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] &&\
eval "$($BASE16_SHELL/profile_helper.sh)"
