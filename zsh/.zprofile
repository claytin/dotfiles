export XDG_CONFIG_HOME="${HOME}/.config"

# auto starts X from the login shell
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
