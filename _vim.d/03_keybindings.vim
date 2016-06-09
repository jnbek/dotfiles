if has('gui_running')
    noremap <S-C-A> ggVG
    noremap <S-C-C> "+y 
    noremap <S-C-V> "+gP
    inoremap <S-C-A> <ESC>ggVG
    inoremap <C-S-C> <ESC>"+ya
    inoremap <S-C-V> <ESC>"+gPa
else
    set mouse=v
endif
" Keymappings
map // :tabnew<Enter>
map ?? :tabnew<Enter>:e .<cr>
map ]] :tabnext<Enter>
map [[ :tabprev<Enter>
map <C-W><C-U> :UndotreeToggle<Enter>
map <C-W><C-H> :help<Enter>
map <C-W><C-F> <Esc>:TagbarToggle<Enter>
map <C-W><C-N> :set number!<Enter>
"https://github.com/kien/tabman.vim
"map <C-W><C-T> :TMToggle<cr>
nmap <C-W><C-B> :NERDTreeToggle<cr>
map <C-W><C-M> :emenu <C-Z>
nnoremap K i<CR><Esc>
" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>
" CVS it
nmap _VC :VCSCommit<Enter>
nmap _VA :VCSAnn<Enter>
nmap _VS :VCSStat<Enter>
nmap _VL :VCSLog<Enter>
nmap _VD :VCSDiff -u
nmap _VU :VCSUpdate<Enter>
nmap _PT ggVG=
vmap _PT =

" Misc Mappings
inoremap <INS> <ESC>a
nnoremap :Q :q
nnoremap :W :w

