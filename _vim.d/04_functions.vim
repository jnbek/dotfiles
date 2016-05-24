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

endfunction

function! PerlKeys()
    noremap _pd :!perldoc <cword> <bar><bar> perldoc -f <cword><cr>
    "Execute it
    nmap _e :!perl -w %<Enter>
    nmap _E :!perl -wc %<Enter>
    " Tidy selected lines (or entire file) with _t:
    nnoremap <silent> _pt :%!perltidy -q<Enter>
    vnoremap <silent> _pt :!perltidy -q<Enter>
    nnoremap <silent> _PT :%!perltidy -q<Enter>
    vnoremap <silent> _PT :!perltidy -q<Enter>
    " Criticize It !!
    nmap _pc :!perlcritic %<Enter>
    nmap _Pc :!perlcritic -brutal %<Enter>
    " Shortcuts
    nmap _sub :call Perl_InsertTemplate("idioms.subroutine")<CR>
    imap _self <ESC>^i    my $self = shift;<cr>
    imap _slurp <ESC>^i my $text = do { local( @ARGV, $/ ) = $file ; <> } ;<cr>
    imap _new <ESC>^isub new {<cr><ESC>^i    my $proto = shift;<cr><ESC>^i    my $class = ref($proto) \|\| $proto;<cr><ESC>^i    my $self = {};<cr><ESC>^i    bless $self, $class;<cr><ESC>^i    return $self;<cr><ESC>^i}<cr>
endfunction

function! PythonKeys()
    nmap _e python %
    nmap _E python -m py_compile %
endfunction

function! RubyKeys()
    nmap _e :!ruby -w %<Enter>
    nmap _E :!ruby -wc %<Enter>
endfunction

function! GoLangKeys()
    nmap _e go run %
    nmap _E gofmt -e %
endfunction
