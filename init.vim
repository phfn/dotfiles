" install Plug
if empty(glob(stdpath('config').'/autoload/'))
  exec "!curl -fLo ".stdpath('config').'/autoload/plug.vim'." --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

source ~/dotfiles/vim/settings.vim
source ~/dotfiles/vim/plugins.vim
