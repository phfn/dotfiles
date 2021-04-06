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
