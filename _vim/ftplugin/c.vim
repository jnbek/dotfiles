" Vim filetype plugin file
"
" Language   :  C / C++
" Plugin     :  c.vim (version 4.1)
" Maintainer :  Fritz Mehner <mehner@fh-swf.de>
" Last Change:  24.06.2006
"
" This will enable keyword completion for C and C++
" using Vim's dictionary feature |i_CTRL-X_CTRL-K|.
" -----------------------------------------------------------------
"
" Only do this when not done yet for this buffer
" 
if exists("b:did_C_ftplugin")
  finish
endif
let b:did_C_ftplugin = 1
"
" ---------- C/C++ dictionary -----------------------------------
" 
if exists("g:C_Dictionary_File")
    silent! exec 'setlocal dictionary+='.g:C_Dictionary_File
endif    
"
" ---------- F-key mappings  ------------------------------------
"
"   Alt-F9   write buffer and compile
"       F9   compile and link
"  Ctrl-F9   run executable
" Shift-F9   command line arguments
"
 map  <buffer>  <silent>  <A-F9>       <C-C>:call C_Compile()<CR>:redraw<CR>:call C_HlMessage()<CR>
imap  <buffer>  <silent>  <A-F9>  <C-C><C-C>:call C_Compile()<CR>:redraw<CR>:call C_HlMessage()<CR>
"
 map  <buffer>  <silent>    <F9>       <C-C>:call C_Link()<CR>:redraw<CR>:call C_HlMessage()<CR>
imap  <buffer>  <silent>    <F9>  <C-C><C-C>:call C_Link()<CR>:redraw<CR>:call C_HlMessage()<CR>
"
" <C-C> seems to be essential here:
 map  <buffer>  <silent>  <C-F9>       <C-C>:call C_Run()<CR>
imap  <buffer>  <silent>  <C-F9>  <C-C><C-C>:call C_Run()<CR>
"
 map  <buffer>  <silent>  <S-F9>       <C-C>:call C_Arguments()<CR>
imap  <buffer>  <silent>  <S-F9>  <C-C><C-C>:call C_Arguments()<CR>
"
" alternate file plugin
"
if exists("loaded_alternateFile")
 map  <buffer>  <silent>  <S-F2>       <C-C>:A<CR>
imap  <buffer>  <silent>  <S-F2>  <C-C><C-C>:A<CR>
endif
"
"
" ---------- KEY MAPPINGS : MENU ENTRIES -------------------------------------
"
" ---------- comments menu  ------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>ce    <Esc>:call C_LineEndComment("/*  */")<CR>$2hi
vmap    <buffer>  <silent>  <Leader>ce    <Esc>:call C_MultiLineEndComments("/*  */")<CR>$2hi
 map    <buffer>  <silent>  <Leader>cn    <Esc>:call C_LineEndComment("// ")<CR>A
vmap    <buffer>  <silent>  <Leader>cn    <Esc>:call C_MultiLineEndComments("// ")<CR>A
 map    <buffer>  <silent>  <Leader>cl    <Esc>:call C_GetLineEndCommCol()<CR>
 map    <buffer>  <silent>  <Leader>ci    <Esc>o/*<CR>/<Esc>kA<Space>
vmap    <buffer>  <silent>  <Leader>ci    <Esc>:call C_CodeComment("v","yes")<CR><Esc>:nohlsearch<CR>
 map    <buffer>  <silent>  <Leader>c*    <Esc>:call C_CodeComment("a","yes")<CR><Esc>:nohlsearch<CR>
vmap    <buffer>  <silent>  <Leader>c*    <Esc>:call C_CodeComment("v","yes")<CR><Esc>:nohlsearch<CR>
 map    <buffer>  <silent>  <Leader>c\    <Esc>:call C_CodeComment("a","no")<CR><Esc>:nohlsearch<CR>
vmap    <buffer>  <silent>  <Leader>c\    <Esc>:call C_CodeComment("v","no")<CR><Esc>:nohlsearch<CR>
 map    <buffer>  <silent>  <Leader>co    <Esc>:call C_CommentCode("a")<CR><Esc>:nohlsearch<CR>
vmap    <buffer>  <silent>  <Leader>co    <Esc>:call C_CommentCode("v")<CR><Esc>:nohlsearch<CR>
 map    <buffer>  <silent>  <Leader>cf    <Esc>:call C_CommentTemplates("frame")<CR>
 map    <buffer>  <silent>  <Leader>cu    <Esc>:call C_CommentTemplates("function")<CR>
 map    <buffer>  <silent>  <Leader>cm    <Esc>:call C_CommentTemplates("method")<CR>
 map    <buffer>  <silent>  <Leader>ca    <Esc>:call C_CommentTemplates("class")<CR>
 map    <buffer>  <silent>  <Leader>cd    a<C-R>=strftime("%x")<CR>
 map    <buffer>  <silent>  <Leader>ct    a<C-R>=strftime("%x %X %Z")<CR>
 map    <buffer>  <silent>  <Leader>cy    <Esc>:call C_Toggle_C_Cpp()<CR>
"
" ---------- statements menu  ------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>sd    <Esc>:call C_DoWhile("a")<CR><Esc>f(la
vmap    <buffer>  <silent>  <Leader>sd    <Esc>:call C_DoWhile("v")<CR><Esc>f(la

 map    <buffer>  <silent>  <Leader>so    <Esc>:call C_Stat("a","for ( ; ; )")<Esc>f;i
vmap    <buffer>  <silent>  <Leader>so    <Esc>:call C_Stat("v","for ( ; ; )")<Esc>f;i

 map    <buffer>  <silent>  <Leader>sr    <Esc>:call C_StatBlock("a","for ( ; ; )")<Esc>f;i
vmap    <buffer>  <silent>  <Leader>sr    <Esc>:call C_StatBlock("v","for ( ; ; )")<Esc>f;i

 map    <buffer>  <silent>  <Leader>si    <Esc>:call C_Stat("a","if (  )")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>si    <Esc>:call C_Stat("v","if (  )")<Esc>f(la

 map    <buffer>  <silent>  <Leader>se    <Esc>:call C_IfElse("a")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>se    <Esc>:call C_IfElse("v")<Esc>f(la

 map    <buffer>  <silent>  <Leader>sf    <Esc>:call C_StatBlock("a","if (  )")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>sf    <Esc>:call C_StatBlock("v","if (  )")<Esc>f(la

 map    <buffer>  <silent>  <Leader>sl    <Esc>:call C_IfBlockElse("a")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>sl    <Esc>:call C_IfBlockElse("v")<Esc>f(la

 map    <buffer>  <silent>  <Leader>sw    <Esc>:call C_Stat("a","while (  )")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>sw    <Esc>:call C_Stat("v","while (  )")<Esc>f(la

 map    <buffer>  <silent>  <Leader>sh    <Esc>:call C_StatBlock("a","while (  )")<Esc>f(la
vmap    <buffer>  <silent>  <Leader>sh    <Esc>:call C_StatBlock("v","while (  )")<Esc>f(la

 map    <buffer>  <silent>  <Leader>ss    <Esc>:call C_CodeSwitch()<Esc>f(la
vmap    <buffer>  <silent>  <Leader>ss    <Esc>:call C_CodeSwitchVisual()<Esc>f(la

 map    <buffer>  <silent>  <Leader>sc    <Esc>ocase 0:<Tab><CR>break;<CR><Esc>2kf0s
vmap    <buffer>  <silent>  <Leader>sc    <Esc>:call C_CodeCaseVisual()<Esc>

 map    <buffer>  <silent>  <Leader>s{    <Esc>:call C_Block("a")<CR>o
vmap    <buffer>  <silent>  <Leader>s{    <Esc>:call C_Block("v")<CR>

"
" ---------- idioms menu  ----------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>if    <Esc>:call C_CodeFunction("a")<CR>
vmap    <buffer>  <silent>  <Leader>if    <Esc>:call C_CodeFunction("v")<CR>
 map    <buffer>  <silent>  <Leader>it    <Esc>:call C_CodeFunction("sa")<CR>w
vmap    <buffer>  <silent>  <Leader>it    <Esc>:call C_CodeFunction("sv")<CR>w
 map    <buffer>  <silent>  <Leader>im    <Esc>:call C_CodeMain()<CR>3jA
"
 map    <buffer>  <silent>  <Leader>i0    <Esc>:call C_CodeFor("up"  )<CR>a
 map    <buffer>  <silent>  <Leader>in    <Esc>:call C_CodeFor("down")<CR>a
"
 map    <buffer>  <silent>  <Leader>ie    <Esc>:call C_EST("enum")<CR>o
 map    <buffer>  <silent>  <Leader>is    <Esc>:call C_EST("struct")<CR>o
 map    <buffer>  <silent>  <Leader>iu    <Esc>:call C_EST("union")<CR>o
"
 map    <buffer>  <silent>  <Leader>ip    <Esc><Esc>oprintf )x\nx);<Esc>2F)r(fxr"fxr"2hi
 map    <buffer>  <silent>  <Leader>ic    <Esc><Esc>oscanf )xx, & );<Esc>2F)r(lr"lr"i
"
 map    <buffer>  <silent>  <Leader>il    <Esc>:call C_CodeMalloc("c")<CR>i
 map    <buffer>  <silent>  <Leader>ia    <Esc>:call C_CodeMalloc("m")<CR>i
"
 map    <buffer>  <silent>  <Leader>iz     isizeof))<Esc>hr(a
vmap    <buffer>  <silent>  <Leader>iz    disizeof))<Esc>hr(pa
 map    <buffer>  <silent>  <Leader>ir    <Esc><Esc>oassert));<Esc>2F)r(a
vmap    <buffer>  <silent>  <Leader>ir    diassert));<Esc>2F)r(pa
"
 map    <buffer>  <silent>  <Leader>ii    <Esc>:call C_CodeFopen("input")<CR>jf"a
 map    <buffer>  <silent>  <Leader>io    <Esc>:call C_CodeFopen("output")<CR>jf"a
"
" ---------- snippet menu ----------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>nr    <Esc>:call C_CodeSnippet("r")<CR>
 map    <buffer>  <silent>  <Leader>nw    <Esc>:call C_CodeSnippet("w")<CR>
vmap    <buffer>  <silent>  <Leader>nw    <Esc>:call C_CodeSnippet("wv")<CR>
 map    <buffer>  <silent>  <Leader>ne    <Esc>:call C_CodeSnippet("e")<CR>
"
 map    <buffer>  <silent>  <Leader>np    <Esc>:call C_ProtoPick("n")<CR>
vmap    <buffer>  <silent>  <Leader>np    <Esc>:call C_ProtoPick("v")<CR>
 map    <buffer>  <silent>  <Leader>ni    <Esc>:call C_ProtoInsert()<CR>
 map    <buffer>  <silent>  <Leader>nc    <Esc>:call C_ProtoClear()<CR>
 map    <buffer>  <silent>  <Leader>ns    <Esc>:call C_ProtoShow()<CR>
"
" ---------- C++ menu ----------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>+d    <Esc>:call C_CodeMethod()<CR>
 map    <buffer>  <silent>  <Leader>+l    <Esc>:call C_CommentTemplates("CppClass")<CR>
 map    <buffer>  <silent>  <Leader>+n    <Esc>:call C_CommentTemplates("CppClassUsingNew")<CR>
 map    <buffer>  <silent>  <Leader>+o    <Esc>:call C_CommentTemplates("CppErrorClass")<CR>
 map    <buffer>  <silent>  <Leader>+t    <Esc>:call C_CommentTemplates("CppTemplateClass")<CR>
 map    <buffer>  <silent>  <Leader>+w    <Esc>:call C_CommentTemplates("CppTemplateClassUsingNew")<CR>
 map    <buffer>  <silent>  <Leader>+f    <Esc>:call C_CodeTemplateFunct()<CR>
 map    <buffer>  <silent>  <Leader>+y    <Esc>:call C_CodeTryCatch("a")<CR>o
vmap    <buffer>  <silent>  <Leader>+y    <Esc>:call C_CodeTryCatch("v")<CR>f(fci
 map    <buffer>  <silent>  <Leader>+h    <Esc>:call C_CodeCatch("a"," const &ExceptObj ")<CR>f(fci
vmap    <buffer>  <silent>  <Leader>+h    <Esc>:call C_CodeCatch("v"," const &ExceptObj ")<CR>f(fci
 map    <buffer>  <silent>  <Leader>+.    <Esc>:call C_CodeCatch("a","...")<CR>
vmap    <buffer>  <silent>  <Leader>+.    <Esc>:call C_CodeCatch("v","...")<CR>
"
" ---------- run menu --------------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>rc    <C-C>:call C_Compile()<CR>:redraw<CR>:call C_HlMessage()<CR>
 map    <buffer>  <silent>  <Leader>rl    <C-C>:call C_Link()<CR>:redraw<CR>:call C_HlMessage()<CR>
 map    <buffer>  <silent>  <Leader>rr    <C-C>:call C_Run()<CR>
 map    <buffer>  <silent>  <Leader>ra    <C-C>:call C_Arguments()<CR>
 map    <buffer>  <silent>  <Leader>rm    <C-C>:call C_Make()<CR>
 map    <buffer>  <silent>  <Leader>rg    <C-C>:call C_MakeArguments()<CR>
 map    <buffer>  <silent>  <Leader>rp    <C-C>:call C_SplintCheck()<CR>:redraw<CR>:call C_HlMessage()<CR>
 map    <buffer>  <silent>  <Leader>ri    <C-C>:call C_SplintArguments()<CR>
 map    <buffer>  <silent>  <Leader>rd    <C-C>:call C_Indent("a")<CR>:redraw<CR>:call C_HlMessage()<CR>
vmap    <buffer>  <silent>  <Leader>rd    <C-C>:call C_Indent("v")<CR>:redraw<CR>:call C_HlMessage()<CR>
 map    <buffer>  <silent>  <Leader>rh    <C-C>:call C_Hardcopy("n")<CR>
vmap    <buffer>  <silent>  <Leader>rh    <C-C>:call C_Hardcopy("v")<CR>
 map    <buffer>  <silent>  <Leader>rs    <C-C>:call C_Settings()<CR>
 if	has("unix")
	 map    <buffer>  <silent>  <Leader>rx    <C-C>:call C_XtermSize()<CR>
 endif
 map    <buffer>  <silent>  <Leader>ro    <C-C>:call C_Toggle_Gvim_Xterm()<CR>
"
" ---------- plugin help -----------------------------------------------------
"
 map    <buffer>  <silent>  <Leader>h    <Esc>:call C_HelpCsupport()<CR>
"
