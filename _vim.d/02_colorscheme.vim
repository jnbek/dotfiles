if has('gui_running')
    if has("win32") || has("win16") || has("win64")
        behave mswin
        "set guifont=Consolas:h9:cANSI:qDRAFT
        set guifont=Lucinda_Console:h10:CANSI:qDRAFT
    else
        set guifont=Monospace\ 9
    endif
    "colorscheme nightshade
    "colorscheme marslo256
    "colorscheme PerfectDark
    colorscheme slate
else
    set t_Co=256
    "colorscheme termpot
    "colorscheme marslo256
    "colorscheme PerfectDark
    colorscheme termpot
endif
"Highlights
"highlight StatusLine ctermfg=8 ctermbg=3
"highlight Title       term=bold cterm=bold ctermbg=7 ctermfg=4 gui=bold guifg=Blue
