export XDG_CONFIG_HOME="${HOME}/.config"

# start mpd
# if not running already && it is available in the system
[[ ! -s $XDG_CONFIG_HOME/mpd/pid ]] &&\
[[ $(which mpd >/dev/null; echo $?) -eq 0 ]] && mpd

# auto starts X from the login shell
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
