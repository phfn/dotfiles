syntax on

let mapleader = " "
"Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'doums/darcula'
"better filetree
Plug 'preservim/nerdtree'
"git in filetree
Plug 'Xuyuanp/nerdtree-git-plugin' 
"icons in filetree
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'
"linter
Plug 'vim-syntastic/syntastic'
" better search 
Plug 'ctrlpvim/ctrlp.vim'
"autoclose ()[]{}
Plug 'jiangmiao/auto-pairs'
"comment things with space+c+space
Plug 'preservim/nerdcommenter'
"autpcomletion in python
Plug 'davidhalter/jedi-vim'
"use s to surround
Plug 'tpope/vim-surround'
"intention with i eg dai deletes a funktion in python
Plug 'michaeljsmith/vim-indent-object'
"venv shit | use :VirtualEnvActivate venv
Plug 'jmcantrell/vim-virtualenv'
call plug#end()

"colour
colorscheme darcula
set termguicolors

"better tabs for python
set tabstop=4
set softtabstop=4

"NERDCommender

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

set encoding=utf-8
set scrolloff=5
set noerrorbells
set number relativenumber
set nowrap
set incsearch
set noswapfile
set ls=2

" open tree with space t
map <leader>t :NERDTreeToggle<CR>
