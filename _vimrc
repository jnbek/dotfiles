for vimfile in split(glob($HOME."/.vim.d/*.vim"),'\n')
    execute "source " . fnameescape(vimfile)
endfor
if filereadable($HOME."/.vim_aliases")
    source $HOME/.vim_aliases
endif
