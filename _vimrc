" Initial Settings
if has('gui_running')
    if has("win32") || has("win16") || has("win64")
        behave mswin
        set guifont=DejaVu_Sans_Mono:h8:cANSI
    else
        set guifont=Monospace\ 9
    endif
    map <S-C-a> ggVG
    map <S-C-c> "+y 
    map <S-C-v> "+gP
    imap <S-C-a> <ESC>ggVG
    imap <C-S-c> <ESC>"+ya
    imap <S-C-v> <ESC>"+gPa
    nnoremap <silent> <S-C-T> :%!perltidy -q<Enter>
    vnoremap <silent> <S-C-T> :!perltidy -q<Enter>
    colorscheme nightshade
else
    set t_Co=256
    colorscheme termpot
    set mouse=v
endif
if filereadable($HOME."/.vim_aliases")
    source $HOME/.vim_aliases
endif
source $VIMRUNTIME/menu.vim
syntax on
filetype on
filetype plugin on
filetype indent on
let s:opt_preserve=1
let g:VCSCommandEnableBufferSetup = 1
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
set modelines=0
set nomodeline
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
"Status Line
set laststatus=2        " ls:  always put a status line
set statusline=%([%{CurTabColor()}]\ %y\ [%f%M%R]\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]%)\ %=\ %(%l/%L,%c%V\ %P\ [%o][0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %)
"set statusline=%([%-n]%y\ [%f%M%R]%)\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]\ %=\ %(%l/%L,%c%V\ %P\ [0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%)
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

" Buf Settings

autocmd BufNewFile,BufRead *.pl,*.pm,*.t              setf perl
autocmd BufNewFile,BufRead *.pmc,*.ops                setf c
autocmd BufNewFile,BufRead *.tt,*.email,*.html,*.htm  setf tt2html
autocmd BufNewFile,BufRead *.phpt                     setf php
autocmd BufNewFile,BufRead *.js,*.gjs                 setf javascript
" FileType Settings

autocmd FileType perl set makeprg=perl\ -wc\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
"autocmd FileType perl set autowrite
autocmd FileType perl call PerlMode()
autocmd FileType perl :noremap _pd :!perldoc <cword> <bar><bar> perldoc -f <cword><cr>
" make lines longer than 80 characters errors
autocmd FileType perl match ErrorMsg /\%>80v.\+/

" make tabs and trailing spaces errors
autocmd FileType perl match ErrorMsg /[\t]\|^\s\+$\|\S\s\+$/

autocmd FileType javascript set makeprg=gjs\ %\ $*
autocmd FileType text call TextMode()
autocmd FileType mail call TextMode()
autocmd FileType vim  set iskeyword+=. iskeyword+=/ iskeyword+=~

autocmd FileType html set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|set autoindent|set smartindent
autocmd FileType tt2html set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|set autoindent|set smartindent
autocmd! BufRead,BufNewFile *.json setfiletype json 

" http://vimdoc.sourceforge.net/htmldoc/vimfaq.html
" " 5.5. How do I configure Vim to open a file at the last edited location?
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal g`\"" |
     \ endif

" Keymappings
map // :tabnew<Enter>
map ?? :tabnew<Enter>:e .<cr>
map ]] :tabnext<Enter>
map [[ :tabprev<Enter>
map <C-W><C-H> :help<Enter>
map <C-W><C-F> <Esc>:TagbarToggle<Enter>
map <C-W><C-N> :set number!<Enter>
map <C-W><C-T> :TMToggle<cr>
nmap <C-W><C-B> :VSBufExplorer<cr>
map <C-W><C-M> :emenu <C-Z>
nnoremap K i<CR><Esc>
"Execute it
nmap _e :!perl -w %<Enter>
nmap _E :!perl -wc %<Enter>
" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>
" Tidy selected lines (or entire file) with _t:
nnoremap <silent> _pt :%!perltidy -q<Enter>
vnoremap <silent> _pt :!perltidy -q<Enter>
nnoremap <silent> _PT :%!perltidy -q<Enter>
vnoremap <silent> _PT :!perltidy -q<Enter>
nmap _HT :call HTMLind()<CR>
nmap _JT :call g:Jsbeautify()<cr><Enter>
" Criticize It !!
nmap _pc :!perlcritic %<Enter>
nmap _Pc :!perlcritic -brutal %<Enter>
" CVS it
nmap _VC :VCSCommit<Enter>
nmap _VA :VCSAnn<Enter>
nmap _VS :VCSStat<Enter>
nmap _VL :VCSLog<Enter>
nmap _VD :VCSDiff -r
nmap _VU :VCSUpdate<Enter>
" Shortcuts
nmap _sub :call Perl_InsertTemplate("idioms.subroutine")<CR>
imap _self <ESC>^i    my $self = shift;<cr>
imap _new <ESC>^isub new {<cr><ESC>^i    my $proto = shift;<cr><ESC>^i    my $class = ref($proto) \|\| $proto;<cr><ESC>^i    my $self = {};<cr><ESC>^i    bless $self, $class;<cr><ESC>^i    return $self;<cr><ESC>^i}<cr>

" Misc Mappings
inoremap <INS> <ESC>a
nnoremap :Q :q
nnoremap :W :w
"Highlights
"highlight StatusLine ctermfg=8 ctermbg=3
"highlight Title       term=bold cterm=bold ctermbg=7 ctermfg=4 gui=bold guifg=Blue
"Functions
function! TextMode()
" Stolen from David Hand
    set nocindent               " nocin:  don't use C-indenting
    set nosmartindent           " nosi:  don't "smart" indent, either
    set autoindent              " ai:  indent to match previous line
    set noshowmatch             " nosm:  don't show matches on parens, brackets, etc.
    set comments=n:>,n:#,fn:-   " com: list of things to be treated as comments
    "set textwidth=72            " tw:  wrap at 72 characters
    set formatoptions=tcrq      " fo:  word wrap, format comments
    set dictionary+=/usr/local/dict/*  " dict:  dict for word completion
    set complete=.,w,b,u,t,i,k  " cpt:  complete words
endfunction

function! PerlMode()
" Stolen from David Hand
    set shiftwidth=4            " sw:  a healthy tab stop
"    set textwidth=72            " tw:  wrap at 72 characters
    set autoindent              " ai:  indent to match previous line
    set cindent                 " cin:  Use C-indenting
    set cinkeys=0{,0},!^F,o,O,e " cink:  Perl-friendly reindent keys
    set cinoptions=t0,+4,(0,)60,u0,*100  " cino:  all sorts of options
    set cinwords=if,else,while,do,for,elsif,sub
    set comments=n:#            " com:  Perlish comments
    set formatoptions=crql      " fo:  word wrap, format comments
    set nosmartindent           " nosi:  Smart indent useless when C-indent is on
    set showmatch               " show matches on parens, bracketc, etc.
endfunction

function! CurrSubName()
    let g:subname = ""
    let g:subrecurssion = 0

    " See if this is a Perl file
    let l:firstline = getline(1)

    if ( l:firstline =~ '#!.*perl' || l:firstline =~ '^package ' )
        call GetSubName(line("."))
    endif
    if &ft =~ '^\v(c|objc|javascript|python|vim)$'
        call functionator#GetName()
    endif
    return g:subname
endfunction
function! GetSubName(line)
    let l:str = getline(a:line)

    if l:str =~ '^sub'
        let l:str = substitute( l:str, " *{.*", "", "" )
        let l:str = substitute( l:str, "sub *", "", "" )
        let g:subname = l:str
        return 1
    elseif ( l:str =~ '^}' || l:str =~ '^}P@ *#' ) && g:subrecurssion == 1
        return -1
    elseif a:line > 2
        let g:subrecurssion = g:subrecurssion + 1
        if g:subrecurssion < 190
            call GetSubName(a:line - 1)
        else
            let g:subname = ': <too deep>'
            return -1
        endif
    else
        return -1
    endif
endfunction
function! CurTabColor() 

  let currentTab = tabpagenr() 
  let s_line= 'Tab #:' . currentTab 
  return s_line 

endf
