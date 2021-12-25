# histroy
HISTSIZE=5000
HISTFILE="$HOME/.zhistory"
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

# PATH setup
# Fix path, make the packages local (use ~/.local/share/<pkg>/bin
for f in ~/.path-append/*; do
    # check if already in PATH
    source $f
done

# set the default editor
ed=($(whereis nvim vim vi nano | cut -d : -f 1))

if [[ $#ed -gt 0 ]]; then # found one of the editors in the $ed line
    export EDITOR="$ed[1]"
else
    export EDITOR="echo -e \"Well... This is some deep shit\!\""
fi

unset ed

# base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"

[[ -n "$PS1" ]] && [[ -s "$BASE16_SHELL/profile_helper.sh" ]] &&\
eval "$("$BASE16_SHELL/profile_helper.sh")"

# Set XDG if not yet
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"

# opam configuration
[[ ! -r /home/wilhelm/.opam/opam-init/init.zsh ]] || \
source /home/wilhelm/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
