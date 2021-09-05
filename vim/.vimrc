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

" stop unnecessary rendering
set lazyredraw

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
scriptencoding utf-8

" behaves like vim (not compatible with vi)
set nocompatible

" documentation on this is meh; enables faster "unsupportert" scrolling for
" slow environments?
set ttyfast

if !has('gui_running')
    set t_Co=256
endif

set lazyredraw
set autoread
set autowrite

" always display status line
set laststatus=2

" set cmd line height to 1
set cmdheight=1

" 5 lines after and before current line when navigating
set scrolloff=5
" wrap lines
set wrap

" indentation
set shiftwidth=4
set tabstop=4

" spaces insted of tabs
set expandtab

" try to be smart about tab and indentation
set smarttab
set autoindent
set smartindent

" highlight matching "block chars
set showmatch
" timeout of
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
set listchars=tab:»\ ,eol:¬,trail:·,nbsp:·
set showbreak=↪

" syntax
syntax enable

" Plugins (vim-plug)
call plug#begin()
" colors
Plug 'chriskempson/base16-vim'

" status line plugin
Plug 'itchyny/lightline.vim'

" some comfy plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" display symbols to indicate the change status of cvs managed files
Plug 'mhinz/vim-signify'

" display undo tree
Plug 'mbbill/undotree'

" kitty highlight
Plug 'fladson/vim-kitty'
call plug#end()

" color scheme
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

set background=light
colo base16-solarized-light

" status line, based on xero's conf (http://xero.nu)
let g:lightline = {
     \ 'colorscheme': 'solarized',
     \
     \ 'active': {
          \ 'left': [ ['bufnum', 'mode'],
                    \ ['readonly', 'filename', 'modified'] ]
          \ },
     \
     \ 'inactive': {
          \ 'left': [ ['bufnum'],
                    \ ['readonly', 'filename', 'modified'] ]
          \ },
     \
     \ 'component': {
          \ 'bufnum': '#%n',
          \ 'readonly': '%{&readonly?"":""}',
          \ 'lineinfo': 'Ln %l, Col %c',
          \ 'percent': ' %L'
          \ },
     \
     \ 'separator': { 'left': "", 'right': " "},
     \ 'subseparator': { 'left': "", 'right': ""}
     \ }

" avoids redundant mode display
set noshowmode

" Goyo conf
let g:goyo_width = 100
function! s:goyo_enter()
     " show line numbers
     set number
     " show right column at 80th character
     set cc=80
     " lime light integration
     Limelight
endfunction

function! s:goyo_leave()
     "
     Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" manualy added plugins autoload
set runtimepath^=~/.vim/bundle/vim-apl/

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

" Appendix

" Old status bar separator setup. Don't lose it!
" separator: \u2597 (dark shade) + \u2592 (medium) + \u2591 (light) & reverse
" subseparator: left: \u2592, right: \u2591
" \ 'mode': '#%n %{WMode()}',
