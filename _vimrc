 augroup gzip
   autocmd BufReadPre,FileReadPre	*.gz,*.bz2,*.Z,*.lzma,*.xz,*.zst setlocal bin
   autocmd BufReadPost,FileReadPost	*.gz  call gzip#read("gzip -dn")
   autocmd BufReadPost,FileReadPost	*.bz2 call gzip#read("bzip2 -d")
   autocmd BufReadPost,FileReadPost	*.Z   call gzip#read("uncompress")
   autocmd BufReadPost,FileReadPost	*.lzma call gzip#read("lzma -d")
   autocmd BufReadPost,FileReadPost	*.xz  call gzip#read("xz -d")
   autocmd BufReadPost,FileReadPost	*.zst  call gzip#read("zstd -q -d --rm")
   autocmd BufWritePost,FileWritePost	*.gz  call gzip#write("gzip")
   autocmd BufWritePost,FileWritePost	*.bz2 call gzip#write("bzip2")
   autocmd BufWritePost,FileWritePost	*.Z   call gzip#write("compress -f")
   autocmd BufWritePost,FileWritePost	*.lzma call gzip#write("lzma -z")
   autocmd BufWritePost,FileWritePost	*.xz  call gzip#write("xz -z")
   autocmd BufWritePost,FileWritePost	*.zst  call gzip#write("zstd -q --rm")
   autocmd FileAppendPre			*.gz  call gzip#appre("gzip -dn")
   autocmd FileAppendPre			*.bz2 call gzip#appre("bzip2 -d")
   autocmd FileAppendPre			*.Z   call gzip#appre("uncompress")
   autocmd FileAppendPre			*.lzma call gzip#appre("lzma -d")
   autocmd FileAppendPre			*.xz   call gzip#appre("xz -d")
   autocmd FileAppendPre			*.zst   call gzip#appre("zstd -q -d --rm")
   autocmd FileAppendPost		*.gz  call gzip#write("gzip")
   autocmd FileAppendPost		*.bz2 call gzip#write("bzip2")
   autocmd FileAppendPost		*.Z   call gzip#write("compress -f")
   autocmd FileAppendPost		*.lzma call gzip#write("lzma -z")
   autocmd FileAppendPost		*.xz call gzip#write("xz -z")
   autocmd FileAppendPost		*.zst call gzip#write("zstd -q --rm")
augroup END

if isdirectory($HOME."/.vim/skel/")
    autocmd BufNewFile *.html 0r ~/.vim/skel/html.skel      | let IndentStyle = "html"
    autocmd BufNewFile *.py   0r ~/.vim/skel/python.skel    | let IndentStyle = "python"
    autocmd BufNewFile *.pl   0r ~/.vim/skel/pl-script.skel | let IndentStyle = "perl"
    autocmd BufNewFile *.pm   0r ~/.vim/skel/pl-module.skel | let IndentStyle = "perl"
    autocmd BufNewFile *.t    0r ~/.vim/skel/pl-test.skel   | let IndentStyle = "perl"
endif

set tabstop=4
set shiftwidth=4
set backspace=2
set incsearch
set hlsearch
set showcmd!
set showmatch
set autoindent
set smartindent
set expandtab
set showmode
set modelines=1
syntax on
filetype on

set laststatus=2        " ls:  always put a status line
set statusline=%(%y\ [%f%M%R]%)\ %=\ %(%l/%L,%c%V\ %P\ [%o][0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %)
set t_Co=256
colorscheme zellner

highlight MatchParen cterm=NONE ctermbg=brown ctermfg=yellow
highlight Search cterm=NONE ctermbg=brown ctermfg=yellow

if filereadable($HOME."/.vim_aliases")
    source $HOME/.vim_aliases
endif
