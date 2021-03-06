" Vim filetype plugin file
" Language:     Perl 6
" Maintainer:   Andy Lester <andy@petdance.com>
" URL:          http://github.com/petdance/vim-perl/tree/master
" Last Change:  2009-04-18
" Contributors: Hinrik Örn Sigurðsson <hinrik.sig@gmail.com>
"
" Based on ftplugin/perl.vim by Dan Sharp <dwsharp at hotmail dot com>

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

setlocal formatoptions+=crq
setlocal comments=:#
setlocal commentstring=#%s

" Change the browse dialog on Win32 to show mainly Perl-related files
if has("gui_win32")
    let b:browsefilter = "Perl Source Files (*.pl)\t*.pl\n" .
		       \ "Perl Modules (*.pm)\t*.pm\n" .
		       \ "Perl Documentation Files (*.pod)\t*.pod\n" .
		       \ "All Files (*.*)\t*.*\n"
endif

" Provided by Ned Konz <ned at bike-nomad dot com>
"---------------------------------------------
setlocal include=\\<\\(use\\\|require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.pm','')
setlocal define=[^A-Za-z_]
setlocal iskeyword=@,48-57,_,192-255

" The following line changes a global variable but is necessary to make
" gf and similar commands work. Thanks to Andrew Pimlott for pointing out
" the problem. If this causes a " problem for you, add an
" after/ftplugin/perl6.vim file that contains
"       set isfname-=:
set isfname+=:

" Set this once, globally.
if !exists("perl6path")
    if executable("perl6")
	if &shellxquote != '"'
	    let perl6path = system('perl6 -e "print join(q/,/,@*INC)"')
	else
	    let perl6path = system("perl6 -e 'print join(q/,/,@*INC)'")
	endif
	let perl6path = substitute(perl6path,',.$',',,','')
    else
	" If we can't call perl6 to get its path, just default to using the
	" current directory and the directory of the current file.
	let perl6path = ".,,"
    endif
endif

let &l:path=perl6path
"---------------------------------------------

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal fo< com< cms< inc< inex< def< isk<" .
	    \         " | unlet! b:browsefilter"

" Restore the saved compatibility options.
let &cpo = s:save_cpo
