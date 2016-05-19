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

