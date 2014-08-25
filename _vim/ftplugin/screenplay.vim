" Vim plugin to assist in writing screenplays compatible with 
" the trelby plaintext screenplay format.
"
" Last Change:  2014-08-20
" Maintainer:   Alex Lance, vim @ alexlance dot com
" License:      This file is placed in the public domain.
"
"
" Features
" ========
"
"  * The tab button and the backspace button have been modified to go
"    backwards and forwards in helpful chunks 
"
"  * Good margins for ACTION and DIALOG
"
"  * Control-p will format a paragraph from under the cursor
"    downwards, relative to the (textwidth) margin
"
"  * Tab complete character names
"  
"  * Hitting enter after DIALOG should align for a new character name 
"
"
" HOW TO INSTALL
"
"  * Drop this file in your ${VIMRUNTIME}/ftplugin/ directory
"  * ensure your instance of vim has these options enabled:
"    :filetype on
"    :filetype plugin on
"    :au BufRead,BufNewFile *.screenplay    set filetype=screenplay
"  * Ensure the suffix the file you are editing is .screenplay and away you
"    go!
"
"
"


" Avoid loading this twice
if exists("loaded_screenplay")
  finish
endif
let loaded_screenplay = 1
let g:counter = []

" Listen for Enter, Tab and Backspace
imap <CR> <C-R>=ScreenplayEnterPressed()<CR>
imap <TAB> <C-R>=ScreenplayTabPressed()<CR>
imap <BS> <C-R>=ScreenplayBackspacePressed()<CR>
imap  <C-R>=ScreenplayBackspacePressed()<CR>

" Reformat paragraph with Ctrl-P in insert and normal mode
imap <C-P> <C-R>=ScreenplayCtrlPPressed()<CR>
map <C-P> i<C-R>=ScreenplayCtrlPPressed()<CR>

" map ctrl-d to clean up all the whitespace so that ctrl-p work correctly
"imap <C-D> !A!<Esc>:%s/^[ ]\{1,}$//g<CR>?!A!<CR>df!i

set tw=60         " Set text width
set expandtab     " Change tabs into spaces
set softtabstop=0 " softtabstop variable can break my custom backspacing
set autoindent    " Set auto indent
set ff=unix       " use unix fileformat
set fo=tcaw       " set formatoptions to allow nice reflowing of text

" Colours - for dark background
highlight Pmenu ctermfg=250  ctermbg=238
highlight PmenuSel ctermfg=white  ctermbg=240
highlight PmenuSbar ctermfg=black  ctermbg=white


function! ScreenplayEnterPressed()
  let [lnum, col] = searchpos('[^ ].*', 'bnc', line("."))

  let len = len(g:counter)
  if len > 0
    let len = len -1
  endif
    
  let prev_col = get(g:counter,len)
  call add(g:counter, printf("%d",col))
  let rtn = "\<CR>"
  set tw=60
 
  " Name -> Dialog
  if col == 23 && !pumvisible()
    set tw=46
    let rtn = "\<CR>\<Esc>I".repeat(' ', 10)

  " Dialog -> New Name
  elseif col == 11
    set tw=46
    let rtn = "\<CR>\<CR>\<Esc>I".repeat(' ', 22)

  " Dialog -> Action
  elseif prev_col == 11 && col == 0
    set tw=60
    let rtn = "\<Esc>I".repeat("\<BS>", 22)
  endif

  return rtn 
endfunction


function! ScreenplayTabPressed()
  let s:x = 4
  let s:extra = ""
  let s:coord = col(".")
  set tw=60
  
  if s:coord < 11
    set tw=60
    let s:x = 11 - s:coord
  elseif s:coord < 19
    set tw=46
    let s:x = 19 - s:coord
  elseif s:coord < 23
    set tw=46
    let s:x = 23 - s:coord
  elseif s:coord == 23
    let s:x = 23 " for CUT TO
  elseif s:coord > 23 && s:coord < 30
    let s:x = 0
    let s:extra = "\<C-X>\<C-U>"
  endif
  
  return repeat(' ', s:x) . s:extra
endfunction


function! ScreenplayBackspacePressed()
  let [lnum, col] = searchpos('[^ ].*', 'bn', line("."))
  let s:x = 1
  
  if col == 0
    let s:coord = col(".")

    if s:coord > 23
      let s:x = s:coord - 23
    elseif s:coord > 11
      let s:x = s:coord - 11
    elseif s:coord == 1
      let s:x = s:coord - 0
    elseif s:coord > 0
      let s:x = s:coord - 1
    endif
  endif

  return repeat("\<BS>", s:x)
endfunction


function! ScreenplayCtrlPPressed()
  let [lnum, col] = searchpos('[^ ].*', 'bnc', line("."))

  if col == 11
    set tw=46
    return "\<Esc>gq}i"
  elseif col == 0
    set tw=60
    return "\<Esc>gq}i"
  endif
  return "\<Esc>gq}i"
endfunction

" This function allows a dropdown list to 
" appear for character names at the top of DIALOG
function! ScreenplayCompleteCharacterName(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    let last_line = str2nr(line("$"))
    let line_num = 1
    let pattern = "^".repeat(" ",22)."[A-Za-z0-9 ']*$"
    "let pattern = 'combination'
    let matches = {}
    let names = []
    let res = []
    
    " need the call to cursos to start the search from the start of doc
    call cursor(1, 1) 

    " loop through all the line
    while line_num <= last_line
      if search(pattern,"cn",line_num) > 0
        let k = substitute(getline(line_num),"^[ ]*","","")
        let k = substitute(k,"[ ]*$","","")
        if !has_key(matches,k) && strlen(k) > 0
          let matches[k] = 1
        endif
      endif
      let line_num = line_num + 1
      call cursor(line_num, 1) 
    endwhile
   
    for key in sort(keys(matches))
      call add(names, key)
    endfor

    for n in names
      if n =~ '^' . a:base
        call add(res, n)
      endif
    endfor
    return res
  endif
endfun
set completefunc=ScreenplayCompleteCharacterName





