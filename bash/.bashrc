# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Base16 Shell
export BASE16_SHELL="$HOME/.config/base16-shell/"

# Because Emacs will not display colors properly without this
export COLORTERM=truecolor

[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    source "$BASE16_SHELL/profile_helper.sh"

# The \ before $ delays the expansion of the call
export PS1="\$(~/.ps1)"

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly
LESS="-R"

# enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile)
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH. This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# Load alias functions
if [ -d ~/.shell.aliases ]; then
    for a in ~/.shell.aliases/*; do
        source $a
    done
fi

# Rust tools
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Go
if [ -d "/usr/local/go/bin" ]; then
	PATH=$PATH:/usr/local/go/bin
fi

# Haskell tools
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

# OCaml tools
if [ -r "$HOME/.opam/opam-init/init.sh" ]; then
    source "$HOME/.opam/opam-init/init.sh" &>/dev/null
fi

# Bat options
if [ -f ~/.bat.opts ]; then
    source ~/.bat.opts
fi

# FZF
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

# FZF options
if [ -f ~/.fzf.opts ]; then
    source ~/.fzf.opts
fi
