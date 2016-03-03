" status line format
" set statusline=\ [%n]\ │            " buffer number + separator
" set statusline+=\ %{WMode()}\ │     " mode + separator
" set statusline+=\ %t\ │             " file name + separator
" set statusline+=\ %h                " help flag
" set statusline+=%r                  " read only flag
" set statusline+=%m                  " modified (if not possible '-') flag
" set statusline+=%=                  " go right
" set statusline+=│\ %{&ff}\          " file format
" set statusline+=│\ %{strlen(&fenc)?&fenc:'none'}\  " file encoding
" set statusline+=│\ %{strlen(&ft)?&ft:'no\ ft'}\    " file type
" set statusline+=│\ %p\%%\           " percentage through file
" set statusline+=│\ [%L]             " total lines
" set statusline+=%l                  " current line
" set statusline+=:%c\                " current column
