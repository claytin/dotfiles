## Start MPD

if test ! -s "$XDG_CONFIG_HOME/mpd/pid" # file size is 0
    mpd
end
