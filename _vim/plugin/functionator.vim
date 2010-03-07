" File: functionator.vim
" Author: Michael Sanders (msanders42 [at] gmail [dot] com)
" Version: 0.2
" Description: Shows the name of the function the cursor is currently in when
"              gn is pressed, and goes to the [count] line of that function when
"              [count]gn is used.
"              Currently supports: C, Obj-C, JavaScript, Python, and Vim script.
"
"              The functions can be placed in either the 'plugin' or
"              'autoload' directory.
" Fixed up how the function names are displayed for use in the Status Line.
if exists('s:did_functionator') || &cp || version < 700
	finish
endif
let s:did_functionator = 1
nn <silent> gn :<c-u>call functionator#GetName()<cr>

fun s:GetFuncName(ft)
	let line = line('.') | let col = col('.')
    if a:ft == 'c' || a:ft == 'objc'
		let funDecl = search('^\w\+.*(', 'bW')
		if !funDecl
			call cursor(line, col)
			if a:ft == 'objc' " Check for method
				let funDecl = search('^\s*\(-\|+\)', 'bW')
				if !funDecl
					call cursor(line, col)
					return []
				endif
				let funName = substitute(getline(funDecl), ':.\{-}\s', ':', 'g')
				let funName = substitute(funName, ':.\{-}$', ':', 'g')
			else
				return []
			endif
		endif
		let funBegin = search('{')
		let funEnd = searchpair('{', '', '}', 'W')
		if !exists('funName')
			let funName = substitute(getline(funDecl), '\s*{', '', '')
		endif
	elseif a:ft == 'javascript'
		let funBegin = search('^\s*function\s\+\w\+\s*(\w*)', 'bWce')
		let funEnd = searchpair('*{', '', '}', 'n')
		let funName = matchstr(getline(funBegin), '\w\+\s*(.*)')
	elseif a:ft == 'python'
		" Go to the first line number out of "if:", "while:", etc. statements
		" inside the current function.
		let funBegin = search('def.*:$', 'bWcn')
		let lnum = line
		while search('\(def\s\+\w\+(.\{-})\)\@<!:', 'bW') > funBegin
			let lnum = line('.')
		endw
		if &et
			let indent = '^'.repeat(' ', indent(lnum) - &sts)
		else
			let indent = '^'.repeat('\t', (indent(lnum) - &ts) / &ts)
		endif
		call cursor(lnum, col)
		let funBegin = search(indent.'def.*:$', 'nbW')
		let funEnd = search(indent.'\S', 'ncW')
		let funName = matchstr(getline(funBegin), '\w\+(.*)')
		let funName = substitute(funName, "def.*", ": ", "" )
		if funEnd == 0 " If no more non-indented text is found the function
		               " must go to the EOF.
			let funEnd = line('$') + 1
		endif
	elseif a:ft == 'vim'
		let funBegin = search('^\s*\<fu\%[nction!]\>', 'bW')
		let funEnd = searchpair('^\s*\<fu\%[nction]\>', '', '^\s*\<endf\%[unction]\>')
		let funName = substitute(getline(funBegin), '^\s*', '', '')
		let funName = substitute(funName, "fu[nction!]\(*\)*", ":", "" )
	endif
	call cursor(line, col)
	if funBegin && funEnd && funEnd > line
		return [funName, line - funBegin, funEnd]
	endif
	return []
endf

fun s:Warning(msg)
	echoh WarningMsg | echo a:msg | echoh None
	return -1
endf

fun functionator#GetName()
	if &ft !~ '^\v(c|objc|javascript|python|vim)$'
		return s:Warning('This filetype is currently not supported by functionator.vim.')
	endif
	let function = s:GetFuncName(&ft)
	if empty(function)
		let g:subname = ''
	elseif !v:count
		let g:subname = function[0]
	else
		let lnum = line('.') - (function[1] - v:count)
		if lnum > function[2]
			let g:subname = 'Line '.lnum.' outside of function.'
		endif
		call cursor(lnum, 0)
	endif
endf
" vim:noet:sw=4:ts=4:ft=vim
