
if exists("current_compiler")
  finish
endif
let current_compiler = "tidy"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" A workable errorformat for tidy
"|| line 8 column 3 - Error: <hfjkashfajkhfaqhfjkashfjka> is not recognized! 
CompilerSet errorformat=%+P%f,
						\%Eline\ %l\ column\ %c\ \-\ Error:\ %m,
                        \%Wline\ %l\ column\ %c\ \-\ Warning:\ %m 


" default make
" CompilerSet makeprg=make
