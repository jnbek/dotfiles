" Buf Settings

autocmd BufNewFile,BufRead *.pl,*.pm,*.t              setf perl
autocmd BufNewFile,BufRead *.pmc,*.ops                setf c
autocmd BufNewFile,BufRead *.tt,*.email,*.html,*.htm  setf tt2html
autocmd BufNewFile,BufRead *.phpt                     setf php
autocmd BufNewFile,BufRead *.js,*.gjs                 setf javascript
autocmd BufNewFile,BufRead *.go                       setf go
autocmd BufNewFile *.html 0r ~/.vim/skel/html.skel   | let IndentStyle = "html"
autocmd BufNewFile *.py   0r ~/.vim/skel/python.skel | let IndentStyle = "python"
" FileType Settings

autocmd FileType perl set makeprg=perl\ -wc\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
"autocmd FileType perl set autowrite
autocmd FileType perl call PerlMode()
" make lines longer than 80 characters errors
autocmd FileType perl match ErrorMsg /\%>80v.\+/

" make tabs and trailing spaces errors
autocmd FileType perl match ErrorMsg /[\t]\|^\s\+$\|\S\s\+$/
" autocmds for specific shortcuts based on language
autocmd FileType perl       call PerlKeys()
autocmd FileType python     call PythonKeys()
autocmd FileType ruby       call RubyKeys()
autocmd FileType go         call GoLangKeys()
autocmd FileType javascript call JScriptKeys()
autocmd FileType cpp        call CKeys()
autocmd FileType c          call CKeys()

"autocmd FileType javascript set makeprg=gjs\ %\ $*
autocmd FileType text call TextMode()
autocmd FileType mail call TextMode()
autocmd FileType vim  set iskeyword+=. iskeyword+=/ iskeyword+=~

autocmd FileType html    set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|set autoindent|set smartindent
autocmd FileType tt2html set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|set autoindent|set smartindent
autocmd! BufRead,BufNewFile *.json setfiletype json 

" http://vimdoc.sourceforge.net/htmldoc/vimfaq.html
" " 5.5. How do I configure Vim to open a file at the last edited location?
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

