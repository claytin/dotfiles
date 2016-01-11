export XDG_CONFIG_HOME="${HOME}/.config"

# start mpd
[[ ! -s $XDG_CONFIG_HOME/mpd/pid ]] && mpd

# auto starts X from the login shell
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
