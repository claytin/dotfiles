# collects mercurial info
function hg_info
    # is this path a repo?
    set -l repo (hg root 2>/dev/null) # repo path

    if not test -z $repo # path is a repo
        # get the repo name only from the repo path string
        set -l repo (basename $repo)

        # wich branch is this?
        set -l branch (hg branch)

        # there are modified files?
        if test (hg status | wc -l) -gt 0
            yield $repo $branch "*"; and return
        end

        yield $repo $branch; and return
    end

    return 1
end

# collects git info
function git_info
    # is this path a repo?
    set -l repo (git rev-parse --show-toplevel 2>/dev/null) # repo path

    if not test -z $repo # path is a repo
        # get the repo name only from the repo path string
        set -l repo (basename $repo)

        # wich branch is this?
        set -l branch (git branch | grep \* | cut -d " " -f 2)

        # there are modified files?
        if test (git status -s | wc -l) -gt 0
            yield $repo $branch "*"; and return
        end

        yield $repo, $branch; and return
    end

    return 1
end

# collects vcs info
function vcs_info
    if set -l info (git_info; or hg_info)
        echo " ░ ░▒▓ $USER ░▒▓ $HOST "
    else
        echo -ne ""
    end
end

function fish_right_prompt
    vcs_info
end
