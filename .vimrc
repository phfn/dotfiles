syntax on

"Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'doums/darcula'
Plug 'preservim/nerdtree'
"Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

colorscheme darcula
set termguicolors

set noerrorbells
set nu
set relativenumber
set nowrap
set incsearch
set noswapfile
set ls=2

