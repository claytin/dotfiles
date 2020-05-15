function ls
    ls -h --group-directories-first --time-style=+"%d-%m-%Y %H:%M" -F $argv
end
