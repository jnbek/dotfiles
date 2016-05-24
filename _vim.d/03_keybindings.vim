if has('gui_running')
    map <S-C-a> ggVG
    map <S-C-c> "+y 
    map <S-C-v> "+gP
    imap <S-C-a> <ESC>ggVG
    imap <C-S-c> <ESC>"+ya
    imap <S-C-v> <ESC>"+gPa
    nnoremap <silent> <S-C-T> :%!perltidy -q<Enter>
    vnoremap <silent> <S-C-T> :!perltidy -q<Enter>
else
    set mouse=v
endif
" Keymappings
map // :tabnew<Enter>
map ?? :tabnew<Enter>:e .<cr>
map ]] :tabnext<Enter>
map [[ :tabprev<Enter>
map <C-W><C-H> :help<Enter>
map <C-W><C-F> <Esc>:TagbarToggle<Enter>
map <C-W><C-N> :set number!<Enter>
map <C-W><C-T> :TMToggle<cr>
nmap <C-W><C-B> :VSBufExplorer<cr>
map <C-W><C-M> :emenu <C-Z>
nnoremap K i<CR><Esc>
" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>
nmap _HT :call HTMLind()<CR>
nmap _JT :call g:Jsbeautify()<cr><Enter>
" CVS it
nmap _VC :VCSCommit<Enter>
nmap _VA :VCSAnn<Enter>
nmap _VS :VCSStat<Enter>
nmap _VL :VCSLog<Enter>
nmap _VD :VCSDiff -u
nmap _VU :VCSUpdate<Enter>

" Misc Mappings
inoremap <INS> <ESC>a
nnoremap :Q :q
nnoremap :W :w

