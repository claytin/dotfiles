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

## prompt
# collects git info
function git_info {
     if [[ ! $(git status 2>&1) =~ "fatal" ]]; then # this is a git [sub]dir
          local ginf_str

          # wich branch is this?
          local branch=$(git branch | grep \*)
          ginf_str="${ginf_str}%F{green}${branch/#"* "/""}%f"

          # there are modified files?
          local mods=$(git status -s | grep M | wc -l)
          [[ $mods -gt 0 ]] && ginf_str="%F{yellow}+%f ${ginf_str}"

          echo "%K{white}(${ginf_str})%k"
     fi
}

# "colapsed" current dir
function cst_pwd {
     local pwd_sz=${#${"${PWD/#$HOME/~}"}} # something is wrong

     if [[ $pwd_sz -gt $COLUMNS ]]; then # dir path to long
          local offset=$(( $pwd_sz - $COLUMNS + 7 )) # 7 aligns path correctly

          echo "... ${${PWD/#$HOME/~}:$offset}"
     else
          echo "${PWD/#$HOME/~}"
     fi
}

function cst_km {
     local km_str="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"

     if [[ $km_str == "NORMAL" ]]; then
          echo "%K{white}%F{blue}░▒▓%f%k%K{blue}%F{black} $km_str %f%k"
     else
          echo "%F{green}░▒▓%f%K{green}%F{black} $km_str %f%k"
     fi
# ▓▒░
}

# precmd function
function prologue {
     # format
     local UPPERBOX="\u250c"
     local UNDERLN="\e[4m"
     local GRAY="\e[37m"
     local RESET="\e[0m"

     local pwd_str=$(cst_pwd)

     echo "$UPPERBOX ${GRAY}${UNDERLN}${pwd_str}${RESET}"
}

function zle-line-init zle-keymap-select {
     local LOWBOX="\u2514"

     PROMPT="$(echo $LOWBOX) %F{magenta}%# %f"
     RPROMPT="$(git_info)$(cst_km)"

     zle reset-prompt
}

add-zsh-hook precmd prologue
zle -N zle-line-init
zle -N zle-keymap-select

export PATH=$PATH:~/.rakudobrew/bin
