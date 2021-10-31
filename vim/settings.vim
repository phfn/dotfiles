syntax on
let mapleader = " "

" when opening a file, change dir to dir of the file
" cd %:h
set mouse=a
" always show signcolumns
set signcolumn=yes

set encoding=utf-8

" curser never reaches the top or bottom
set scrolloff=5

set noerrorbells

set number relativenumber

" seaching should stop at the end of the file
set nowrap

" open splits more naturally
set splitright

" sea search results while typing
set incsearch

" no .swp files 
set noswapfile

"This makes Vim show a status line even when only one window is shown.
set ls=2

"better tabs for python
au BufEnter *.py set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

let g:python_highlight_all = 1
" enable cool coulours
set termguicolors

map <leader>so :w <bar> :source $MYVIMRC<CR>
map <Tab> :tabNext<CR>
map <leader><Tab> :tabnew<CR>

map <leader>q <C-W>q

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" press <F9> to run a file
source ~/dotfiles/vim/run.vim

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

" Close Terminal
tnoremap <leader><ESC> <C-\><C-n>

" make current buffer terminal
if has("win32")
	" user powershell insted of cmd
	nnoremap <leader>s :e term://powershell<CR>
	nnoremap <leader>S :vs term://powershell<CR>
endif
if has("unix")
	nnoremap <leader>s :term<CR>
	nnoremap <leader>S :vs term://bash<CR>
endif


nnoremap Y y$

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'zmz

" undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
