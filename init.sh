echo "source ~/dotfiles/.vimrc" >> ~/.vimrc
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/
echo "source ~/dotfiles/init.vim" >> ~/.config/nvim/init.vim
echo "source ~/dotfiles/ginit.vim" >> ~/.config/nvim/ginit.vim
echo "source ~/dotfiles/.tmux.conf" >> ~/.tmux.conf
cp ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
cp ~/dotfiles/vim/coc-settings.json ~/.vim/coc-settings.json
~/dotfiles/git/init.sh
./keyboard/init.sh
./requirements/init.sh
