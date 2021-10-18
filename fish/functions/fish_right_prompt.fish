function fish_right_prompt
    # print only the basename, and if in $HOME only its alias '~'
    set -l cwd (basename (pwd) | string replace (basename $HOME) '~')

    test $cwd != '~' && set cwd '.../'$cwd
    cecho --under $cwd
end
