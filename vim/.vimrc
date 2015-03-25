" make backspace behaves like it should
set backspace=indent,eol,start

" remap ':' to ';' (exercise of lazyness)
nnoremap ; :
vnoremap ; :
" force me to use ';' insted of ':'
nnoremap : <nop>
vnoremap : <nop>

" force me to do not scape fro A
nnoremap A<esc> <nop>

" menu copletion feature behaves more like shell(zsh) completion
set wildmenu
set wildmode=list:longest

" menu ignore settings on completion
set wildignore+=*.o,*.out,*.gch        " compiled files
set wildignore+=*.zip,*.rar,*.gz,*.bz2 " compressed files

" leader
let mapleader = ","
let maplocalleader = "\\"

" timeout
set notimeout
set ttimeout
set ttimeoutlen=5

" try to be smart about case when searching
set ignorecase
set smartcase
" highlight search
set hlsearch
set incsearch

" very-magic mode on, when doing regex search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" puts new buffer right (:vs)
set splitright
" puts new buffer below (:sp)
set splitbelow

" make splits proportionaly when resize
au VimResized * :wincmd =

" clear seachr highlight
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" remove trailing ws
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" helps with identation on visual mode
vnoremap > >gv
vnoremap < <gv

" deletes to the end of line
nnoremap D d$

" split lines; sister to J
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" do not move when find matches under cursor
nnoremap * *<c-o>
nnoremap # #<c-o>

" move beg and end of line
nnoremap H ^
nnoremap L g_

" move beg and end of line
nnoremap <localleader>u gUiw
nnoremap <localleader>y gUiwea

set shell=/bin/zsh

set encoding=utf-8

" behaves like vim (not compatible with vi)
set nocompatible

set ttyfast
set t_Co=256

set lazyredraw
set autoread
set autowrite

" always display status line
set laststatus=2
" status line format
function! WMode()
     let m=mode()

     if m == 'i'
          return 'INSERT'
     elseif m == 'v'
          return 'VISUAL'
     elseif m == 'r'
          return 'REPLACE'
     endif

     return 'NORMAL'
endfunction

set statusline=\ [%n]\ ⮁            " buffer number + separator
set statusline+=\ %{WMode()}\ ⮁     " mode + separator
set statusline+=\ %t\ ⮁             " file name + separator
set statusline+=\ %h                " help flag
set statusline+=%r                  " read only flag
set statusline+=%m                  " modified (if not possible '-') flag
set statusline+=%=                  " go right
set statusline+=⮃\ %{&ff}\          " file format
set statusline+=⮃\ %{strlen(&fenc)?&fenc:'none'}\  " file encoding
set statusline+=⮃\ %{strlen(&ft)?&ft:'no\ ft'}\    " file type
set statusline+=⮃\ %p\%%\           " percentage through file
set statusline+=⮃\ [%L]             " total lines
set statusline+=%l                  " current line
set statusline+=:%c\                " current column

" set cmd line height to 1
set cmdheight=1

" 5 lines after and before current line when navigating
set scrolloff=5
" wrap lines
set wrap

" indentation
set shiftwidth=5
set tabstop=5

" spaces insted of tabs
set expandtab

" try to be smart about tab and indentation
set smarttab
set autoindent
set smartindent

" -- highlight matching "block chars
set showmatch
" -- timeout of
set matchtime=4

" some dirs and backup
set backup
set noswapfile

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" scratch buffer
function! OpenScratch(cmd_str)
     exe a:cmd_str . " __scratch__"
endfunction

function! MarkAsScratch()
     setlocal buftype=nofile
     setlocal bufhidden=hide
     setlocal noswapfile
     setlocal buflisted
endfunction

autocmd BufNewFile __scratch__ call MarkAsScratch()

command! -nargs=0 Scratch call OpenScratch("edit")
command! -nargs=0 Sscratch call OpenScratch("sp")
command! -nargs=0 Vscratch call OpenScratch("vs")

" draw right vertical rule at char 80
set cc=80
" show line numbers
set number
" highlight the current line
set cursorline
" hidden chars
set list
set listchars=tab:‣\ ,eol:¬,trail:·,nbsp:·
set showbreak=↳

" syntax
syntax enable
" color scheme
colorscheme jellybeans

" gui opts (gvim)
if has('gui_running')
     " no toolbar
     set guioptions-=T
     " no menu
     set guioptions-=m

     " no right scrollbar
     set guioptions-=r
     " no left scrollbar
     set guioptions-=L

     set guifont=Envy\ Code\ R\ 9

     " geometry
     set lines=30 columns=120
endif
