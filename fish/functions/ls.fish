function ls
    command ls -h --color=auto \
                  --group-directories-first \
                  --time-style=+"%d/%m/%Y %H:%M" \
                  -F $argv
end
