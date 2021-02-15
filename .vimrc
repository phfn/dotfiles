syntax on
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'doums/darcula'
call plug#end()
colorscheme darcula
set termguicolors
set noerrorbells
set nu
set relativenumber
set nowrap
set incsearch
