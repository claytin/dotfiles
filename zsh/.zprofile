export XDG_CONFIG_HOME="${HOME}/.config"

[ ! -s ~/.config/mpd/pid ] && mpd ~/.config/mpd/mpd.conf

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx # verificar

xrandr --output LVDS1 --off
