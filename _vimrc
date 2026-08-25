 augroup gzip
   autocmd BufReadPre,FileReadPre	    *.gz,*.bz2,*.Z,*.lzma,*.xz,*.zst setlocal bin
   autocmd BufReadPost,FileReadPost	    *.gz  call gzip#read("gzip -dn")
   autocmd BufReadPost,FileReadPost	    *.bz2 call gzip#read("bzip2 -d")
   autocmd BufReadPost,FileReadPost	    *.Z   call gzip#read("uncompress")
   autocmd BufReadPost,FileReadPost	    *.lzma call gzip#read("lzma -d")
   autocmd BufReadPost,FileReadPost	    *.xz  call gzip#read("xz -d")
   autocmd BufReadPost,FileReadPost	    *.zst  call gzip#read("zstd -q -d --rm")
   autocmd BufWritePost,FileWritePost	*.gz  call gzip#write("gzip")
   autocmd BufWritePost,FileWritePost	*.bz2 call gzip#write("bzip2")
   autocmd BufWritePost,FileWritePost	*.Z   call gzip#write("compress -f")
   autocmd BufWritePost,FileWritePost	*.lzma call gzip#write("lzma -z")
   autocmd BufWritePost,FileWritePost	*.xz  call gzip#write("xz -z")
   autocmd BufWritePost,FileWritePost	*.zst  call gzip#write("zstd -q --rm")
   autocmd FileAppendPre			    *.gz  call gzip#appre("gzip -dn")
   autocmd FileAppendPre			    *.bz2 call gzip#appre("bzip2 -d")
   autocmd FileAppendPre			    *.Z   call gzip#appre("uncompress")
   autocmd FileAppendPre			    *.lzma call gzip#appre("lzma -d")
   autocmd FileAppendPre			    *.xz   call gzip#appre("xz -d")
   autocmd FileAppendPre			    *.zst   call gzip#appre("zstd -q -d --rm")
   autocmd FileAppendPost		        *.gz  call gzip#write("gzip")
   autocmd FileAppendPost		        *.bz2 call gzip#write("bzip2")
   autocmd FileAppendPost		        *.Z   call gzip#write("compress -f")
   autocmd FileAppendPost		        *.lzma call gzip#write("lzma -z")
   autocmd FileAppendPost		        *.xz call gzip#write("xz -z")
   autocmd FileAppendPost		        *.zst call gzip#write("zstd -q --rm")
augroup END

if isdirectory($HOME."/.vim/skel/")
    autocmd BufNewFile *.html 0r $HOME/.vim/skel/html.skel      | let IndentStyle = "html"
    autocmd BufNewFile *.py   0r $HOME/.vim/skel/python.skel    | let IndentStyle = "python"
    autocmd BufNewFile *.pl   0r $HOME/.vim/skel/pl-script.skel | let IndentStyle = "perl"
    autocmd BufNewFile *.pm   0r $HOME/.vim/skel/pl-module.skel | let IndentStyle = "perl"
    autocmd BufNewFile *.t    0r $HOME/.vim/skel/pl-test.skel   | let IndentStyle = "perl"
endif

syntax on
filetype on

set t_Co=256
set showcmd!
set showmode
set hlsearch
set incsearch
set showmatch
set expandtab
set tabstop=4
set autoindent
set backspace=2
set smartindent
set modelines=1
set shiftwidth=4
set laststatus=2
colorscheme zellner
set statusline=%(%y\ [%f%M%R]%)\ %=\ %(%l/%L,%c%V\ %P\ [%o][0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %)

highlight MatchParen cterm=NONE ctermbg=brown ctermfg=yellow
highlight Search cterm=NONE ctermbg=brown ctermfg=yellow


if has('gui_running')
    noremap <S-C-A> ggVG
    noremap <S-C-C> "+y
    noremap <S-C-V> "+gP
    inoremap <S-C-A> <ESC>ggVG
    inoremap <C-S-C> <ESC>"+ya
    inoremap <S-C-V> <ESC>"+gPa
    vnoremap <S-C-A> ggVG
    vnoremap <S-C-C> "+y
    vnoremap <S-C-V> "+gP
else
    set mouse=v
endif

vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

nmap <silent> _PT <ESC>ggVG=<Enter>
vmap <silent>_PT =

if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'javascript' || &filetype == 'json' || &filetype == 'cs' || &filetype == 'objc'
    if filereadable($HOME."/.clang-format")
        nnoremap _PT :!clang-format -style=LLVM -i %<Enter>
    endif
elseif &filetype == 'perl'
    "Execute it
    nmap _e :!perl -w %<Enter>
    nmap _E :!perl -wc %<Enter>
    " Tidy selected lines (or entire file) with _t:
    nnoremap <silent> _PT :%!perltidy -q<Enter>
    vnoremap <silent> _PT :!perltidy -q<Enter>
    " Shortcuts
    imap _self <ESC>^i   my $self = shift;<cr>
    imap _slurp <ESC>^imy $text = do { local( @ARGV, $/ ) = $file ; <> } ;<cr>
    imap _new <ESC>^isub new {<cr><ESC>^i    my $proto = shift;<cr><ESC>^i    my $class = ref($proto) \|\| $proto;<cr><ESC>^i    my $self = {};<cr><ESC>^i    bless $self, $class;<cr><ESC>^i    return $self;<cr><ESC>^i}<cr>
endif

if filereadable($HOME."/.vim_aliases")
    source $HOME/.vim_aliases
endif
