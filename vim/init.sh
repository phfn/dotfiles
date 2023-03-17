#!/bin/bash

#vim
echo "source ~/dotfiles/.vimrc" >> ~/.vimrc

#nvim
mkdir -p /home/phfn/.config/nvim/lua
echo "source ~/dotfiles/init.vim" >> ~/.config/nvim/init.vim
ln -s /home/phfn/dotfiles/vim/phfn_nvim /home/phfn/.config/nvim/lua/phfn_nvim
