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
    cecho --bold --color=(vi-mode-color) -n "% "
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
    # are there uncommited changes
    if test ! -z "($vcs status 2> /dev/null)"
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

    repo-status git

    # selects the active branch and strips the "* " prefix
    branch=(gbran | grep "^*" | string sub -s3) cecho --color=cyan -n "$branch "
end

function hg-info
    vcs hg; repo && echo -n " at "

    repo-status hg

    cecho --color=cyan -n "$(hg branch) "
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
    cmd-status $st; _jobs; vcs-info; prompt-char
end
