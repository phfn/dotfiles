#!/bin/bash

#vim
echo "source ~/dotfiles/.vimrc" >> ~/.vimrc

#nvim
mkdir -p ~/.config/nvim/lua
echo "source ~/dotfiles/init.vim" >> ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/phfn_nvim ~/.config/nvim/lua/phfn_nvim
