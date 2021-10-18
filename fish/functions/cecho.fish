# (c)olor echo
function cecho -d "Prints its arguments list, but with color"
    argparse --name 'cecho' --ignore-unknown \
        b/bold i/italic u/under c/color= -- $argv

    if set -q _flag_bold
        set fmtstr $fmtstr --bold
    end

    if set -q _flag_italic
        set fmtstr $fmtstr --italic
    end

    if set -q _flag_under
        set fmtstr $fmtstr --underline
    end

    if set -q _flag_color
        set fmtstr $fmtstr $_flag_color
    end

    set_color {$fmtstr}; echo {$argv}
    set_color normal
end
