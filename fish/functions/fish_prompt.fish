# checks if there are suspended jobs
function jobs_
    if test (jobs | wc -l) -gt 0
        echo -ne "▒ " (set_color yellow) "\!" (set_color normal) " ▓▒░ "
        return
    end

    echo -ne ""
end

function fish_prompt
    set_color -b brown
    echo $USER "▓▒░" $HOST "▓▒░ " (jobs_)
    set_color -b normal
end
