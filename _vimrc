" Initial Settings
if has('gui_running')
    "colorscheme habiLight
    colorscheme molokai
    if has("win32") || has("win16") || has("win64")
        behave mswin
        set guifont=DejaVu_Sans_Mono:h8:cANSI
    else
        set guifont=Monospace\ 9
    endif
    map <C-S-A> ggVG
    map <C-S-C> "+y 
    map <C-S-V> "+gP
    imap <C-S-A> <ESC>ggVG
    imap <C-S-C> <ESC>"+y<cr>i
    imap <C-S-V> <ESC>"+gP<cr>i
else
    colorscheme jnbeks
endif
if filereadable($HOME."/.vim_aliases")
    source $HOME/.vim_aliases
endif
source $VIMRUNTIME/menu.vim
set tpm=25
set mouse=nv
set ttymouse=xterm2
set dir=$HOME/tmp/vim
set backup
set bex=.vbak
set bdir=$HOME/tmp/vim/bak
set backupcopy=auto
set wildmenu
set cpo-=<
set pastetoggle=<C-p><C-p>
set wcm=<C-Z>
set sc!
set autoindent
set smartindent
set nu!
set ls=2
syn on
filetype on
filetype plugin on
filetype indent on
set tabstop=4
set expandtab
set shiftwidth=4
"set autowrite
set errorformat=%m\ in\ %f\ on\ line\ %l
let g:VCSCommandEnableBufferSetup = 1
"Status Line
"set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P
set laststatus=2        " ls:  always put a status line
set statusline=%([%{CurTabColor()}]\ %y\ [%f%M%R]\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]%)\ %=\ %(%l/%L,%c%V\ %P\ [%o][0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %)
"set statusline=%([%-n]%y\ [%f%M%R]%)\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]\ %=\ %(%l/%L,%c%V\ %P\ [0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%)
set maxfuncdepth=1000   " Need more depth for sub names
set showmode
set matchpairs+=<:>
set backspace=2
set incsearch
set hlsearch
set showmatch  " show matches on parens, bracketc, etc.
hi MatchParen cterm=NONE ctermbg=brown ctermfg=yellow
hi Search cterm=NONE ctermbg=brown ctermfg=yellow
let s:opt_preserve=1
" Buf Settings

" http://vimdoc.sourceforge.net/htmldoc/vimfaq.html
" " 5.5. How do I configure Vim to open a file at the last edited location?
au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal g`\"" |
     \ endif

au BufNewFile,BufRead *.pl,*.pm,*.t             setf perl
au BufNewFile,BufRead *.pmc,*.ops               setf c
au BufNewFile,BufRead *.tt,*.ttml,*.email       setf tt2html
au BufNewFile,BufRead *.phpt                    setf php
au BufNewFile,BufRead *.js,*.gjs                setf javascript
" FileType Settings

au FileType perl set makeprg=perl\ -wc\ %\ $*
au FileType perl set errorformat=%f:%l:%m
"au FileType perl set autowrite
au FileType perl call PerlMode()
au FileType perl :noremap _pd :!perldoc <cword> <bar><bar> perldoc -f <cword><cr>
" make lines longer than 80 characters errors
au FileType perl match ErrorMsg /\%>80v.\+/

" make tabs and trailing spaces errors
au FileType perl match ErrorMsg /[\t]\|^\s\+$\|\S\s\+$/

au FileType javascript set makeprg=gjs\ %\ $*
au FileType text call TextMode()
au FileType mail call TextMode()
au FileType vim  set iskeyword+=. iskeyword+=/ iskeyword+=~

au FileType html set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2|set autoindent|set smartindent
au FileType tt2html set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2|set autoindent|set smartindent
au! BufRead,BufNewFile *.json setfiletype json 
" Lang Specific Settings

"PHP Settings
  let php_sql_query = 1
  let php_baselib = 1
  let php_parent_error_close = 1
  let php_parent_error_open = 1
  let php_folding = 0
  let php_sync_method = -1
"Perl Settings
  let perl_parent_error_close = 1
  let perl_parent_error_open = 1
  let perl_want_scope_in_variables=1
  let perl_extended_vars=1
  let perl_include_pod=1

" Keymappings
map // :tabnew<Enter>
map ?? :tabnew<Enter>:e .<cr>
map ]] :tabnext<Enter>
map [[ :tabprev<Enter>
map <C-W><C-H> :help<Enter>
map <C-W><C-F> <Esc>:TagbarToggle<Enter>
map <C-W><C-N> :set nu!<Enter>
map <C-W><C-T> :TMToggle<cr>
nmap <C-W><C-B> :VSBufExplorer<cr>
map <C-W><C-M> :emenu <C-Z>
nnoremap K i<CR><Esc>
noremap <silent> _DOC :call OnlineDoc()<CR>
inoremap <silent> _DOC <Esc>:call OnlineDoc()<CR>
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
" Debug It
nmap _DB :call CallPDB()<Enter>
"Profile it
" These require SmallProf and NYTProf and are configured for work
nmap _SP :!export VAR=`pwd`;cd ~;perl -d:SmallProf $VAR/%;less smallprof.out;cd -<cr>|mode
nmap _NP :!perl -d:NYTProf %;nytprofhtml -o /var/www/html/nytprof/;lynx /var/www/html/nytprof/index.html;rm nytprof.out<cr>|mode
" CVS it
nmap _VC :VCSCommit<Enter>
nmap _VA :VCSAnn<Enter>
nmap _VS :VCSStat<Enter>
nmap _VL :VCSLog<Enter>
nmap _VD :VCSDiff<Enter>
nmap _VU :VCSUpdate<Enter>
" Shortcuts
nmap _sub :call Perl_InsertTemplate("idioms.subroutine")<CR>
imap _self <ESC>^i    my $self = shift;<cr>
imap _new <ESC>^isub new {<cr><ESC>^i    my $proto = shift;<cr><ESC>^i    my $class = ref($proto) \|\| $proto;<cr><ESC>^i    my $self = {};<cr><ESC>^i    bless $self, $class;<cr><ESC>^i    return $self;<cr><ESC>^i}<cr>
imap _{ {<cr><cr><ESC>^i}<ESC><ESC>k<ESC>i

" Misc Mappings
inoremap _TC :call MyCompletion()<cr>
inoremap <INS> <ESC>a
nnoremap :Q :q
nnoremap :W :w
"Highlights
"highlight StatusLine ctermfg=8 ctermbg=3
"highlight Title       term=bold cterm=bold ctermbg=7 ctermfg=4 gui=bold guifg=Blue
set tw=0
"Functions
function! CallPDB()
    :!perl -d:PDB %
    :mode
endfunction

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

" From http://www.perlmonks.org/?node_id=540411
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
" Add the following lines to your ~/.vimrc to enable online documentation
" http://vim.wikia.com/wiki/Online_documentation_for_word_under_cursor

function Browser()
    if has("win32") || has("win64")
        let s:browser = "C:\\Program Files\\Mozilla Firefox\\firefox.exe -new-tab"
    elseif has("win32unix") " Cygwin
        let s:browser = "'/cygdrive/c/Program\ Files/Mozilla\ Firefox/firefox.exe' -new-tab"
    elseif has("mac") || has("macunix") || has("unix")
        let s:browser = "lynx"
    endif
    return s:browser
endfunction
function Run(command)
    if has("win32") || has("win64")
        let s:startCommand = "!start"
        let s:endCommand = ""
    elseif has("mac") || has("macunix") " TODO Untested on Mac
        let s:startCommand = "!open -a"
        let s:endCommand = ""
    elseif has("unix") || has("win32unix")
        let s:startCommand = "!"
        let s:endCommand = ""
    else
        echo "Don't know how to handle this OS!"
        finish
    endif

    let s:cmd = "silent " . s:startCommand . " " . a:command . " " . s:endCommand
    " echo s:cmd
    execute s:cmd
    :mode
endfunction
function OnlineDoc()
    if &filetype == "viki"
        " Dictionary
        let s:urlTemplate = "http://dictionary.reference.com/browse/<name>"
    elseif &filetype == "perl"
        let s:urlTemplate = "http://perldoc.perl.org/functions/<name>.html"
    elseif &filetype == "python"
        let s:urlTemplate = "http://www.google.com/search?q=<name>&domains=docs.python.org&sitesearch=docs.python.org"
    elseif &filetype == "ruby"
        let s:urlTemplate = "http://www.ruby-doc.org/core/classes/<name>.html"
    elseif &filetype == "vim"
        let s:urlTemplate = "http://vimdoc.sourceforge.net/search.php?search=<name>&docs=help"
    endif

    let s:wordUnderCursor = expand("<cword>")
    let s:url = substitute(s:urlTemplate, '<name>', s:wordUnderCursor, 'g')
    call Run(Browser() . " " . s:url)
endfunction

function! MyCompletion()
    let col = col('.') - 1
    if col==0 || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction
fu! CurTabColor() 

  let currentTab = tabpagenr() 
  let s_line= 'Tab #:' . currentTab 
  return s_line 

endf