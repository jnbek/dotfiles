if filereadable($VIMRUNTIME."/menu.vim")
    source $VIMRUNTIME/menu.vim
endif
syntax on
filetype on
filetype plugin on
filetype indent on
let s:opt_preserve=1
let php_sql_query = 1
let php_baselib = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 0
let php_sync_method = -1
let perl_parent_error_close = 1
let perl_parent_error_open = 1
let perl_want_scope_in_variables=1
let perl_extended_vars=1
let perl_include_pod=1

set tabpagemax=25
set modelines=1
"set nomodeline
set ttymouse=xterm2
set dir^=$HOME/tmp/vim//
set bex=.vbak
set bdir=$HOME/tmp/vim/bak
set backupcopy=auto
set textwidth=0
set cpoptions-=<
set pastetoggle=<C-p><C-p>
set wildcharm=<C-Z>
set matchpairs+=<:>
set tabstop=4
set shiftwidth=4
set backspace=2
set errorformat=%m\ in\ %f\ on\ line\ %l
set maxfuncdepth=1000   " Need more depth for sub names
set showmode
set backup
set expandtab
set wildmenu
set showcmd!
set autoindent
set smartindent
set number!
set incsearch
set hlsearch
set showmatch
highlight MatchParen cterm=NONE ctermbg=brown ctermfg=yellow
highlight Search cterm=NONE ctermbg=brown ctermfg=yellow
