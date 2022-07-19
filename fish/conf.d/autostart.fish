## Start MPD
if test -z (command -v mpd)
    exit 1
end

if test -s "$XDG_CONFIG_HOME/mpd/pid"
    mpd
end
