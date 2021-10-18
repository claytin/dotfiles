# color code according to fish_bind_mode
function vi-mode-color
    switch $fish_bind_mode
    case default
        echo -n 'blue'
    case insert
        echo -n 'white'
    case replace_one
        echo -n 'green'
    case visual
        solarized_magenta='d33682' echo -n $solarized_magenta
    case '*'
        echo -n 'red'
    end
end

# prints the appropriate prompt char
# if so, prints a yellow indicator
function prompt-char
    status is-interactive && set -l pc 'λ ' || set -l pc '> '
    cecho --bold --color=(vi-mode-color) -n $pc
end

# checks if there are suspended jobs
function _jobs
    if j -q # there are jobs
        cecho --bold --color=yellow -en \!
    end
end

# checks the exit status of the last executed job
# prints a red indicator if the command failed
function cmd-status -a st
    if test $st -ne 0
        cecho --bold --color=red -en \!
    end
end

# takes a vcs, checks if there are any changes to its state
# if so, add a '*' character to the prompt
function repo-status -a vcs
    mods=($vcs status | wc -l) \
    if test $mods -gt 0 # are there uncommited changes
        cecho --color=cyan -n '*'
    end
end

# formats the basename name of the current repo
function repo
    repo=(basename (pwd)) cecho --bold --color=blue -n $repo
end

# formats the vcs parameter into a "nicer" string
function vcs -a vcs
    cecho --color=magenta -n "($vcs) "
end

function git-info
    vcs git; repo && echo -n " at "

    # selects the active branch and strips the "* " prefix
    branch=(gbran | grep "^*" | string sub -s3) cecho --color=cyan -n $branch

    repo-status git
end

function hg-info
    vcs hg; repo && echo -n " at "

    cecho --color=cyan -n (hg branch)

    repo-status hg
end

function vcs-info
    # git
    repo=(git rev-parse --show-toplevel 2>/dev/null) \
    if test -n "$repo" # this is a git repo
        git-info
        return 0
    end

    # mercurial
    repo=(hg root 2>/dev/null) \
    if test -n "$repo" # this is a mercurial repo
        hg-info
    end
end

function fish_prompt
    # store last cmd return value before executing another cmd
    set -l st $status

    # the layout of the commands that follow illustrate the prompt layout
    vcs-info; echo
    cmd-status $st; _jobs; prompt-char
end
