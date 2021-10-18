# set the default editor
set ed (whereis nvim vim vi nano | cut -d : -f 1)

if test (count $ed) -gt 0 # found one of the editors in the $ed line
    set -x EDITOR $ed[1]
else
    set -x EDITOR "echo -e \"Well... This is some deep shit\!\""
end
