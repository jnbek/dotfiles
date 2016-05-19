"Status Line
let g:VCSCommandEnableBufferSetup = 1
set laststatus=2        " ls:  always put a status line
set statusline=%([%{CurTabColor()}]\ %y\ [%f%M%R]\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]%)\ %=\ %(%l/%L,%c%V\ %P\ [%o][0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]\ %)
"set statusline=%([%-n]%y\ [%f%M%R]%)\ [%{CurrSubName()}]\ [%{VCSCommandGetStatusLine()}]\ %=\ %(%l/%L,%c%V\ %P\ [0x%02.2B][%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%)

