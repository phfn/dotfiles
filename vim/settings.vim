syntax on
let mapleader = " "


set encoding=utf-8

" curser never reaches the top or bottom
set scrolloff=5

set noerrorbells

set number relativenumber

" seaching should stop at the end of the file
set nowrap

" sea search results while typing
set incsearch

" no .swp files 
set noswapfile

"This makes Vim show a status line even when only one window is shown.
set ls=2

"better tabs for python
set tabstop=4
set softtabstop=4

let g:python_highlight_all = 1
" enable cool coulours
set termguicolors

map <leader>so :w <bar> :source $MYVIMRC<CR>
map <Tab> :tabNext<CR>
map <leader><Tab> <C-W>w

map <leader>q <C-W>q

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <F9> :w <bar> !python %<CR>
map <F19> :w <bar> !python %<Up><CR>

" unendless undo
" guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
    " define a path to store persistent_undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    " point Vim to the defined undo directory.
    let &undodir = target_path

    " finally, enable undo persistence.
    set undofile
endif

map <F9> :w <CR> :!python %<CR>
map <F19> :w <CR> :!python %<Up><CR>
