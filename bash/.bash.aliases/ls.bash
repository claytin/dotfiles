ls() {
    command ls --human-readable --color=auto \
               --group-directories-first \
               --time-style=+"%d/%m/%Y %H:%M" \
               --classify $@
}
