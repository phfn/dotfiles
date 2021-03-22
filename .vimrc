"Plug
if has("win32")
	if empty(glob($HOME.'/vimfiles/autoload/plug.vim'))
		exec "!curl -fLo ".$HOME.'/vimfiles/autoload/plug.vim'." --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    endif
endif
if has("unix")
	if empty(glob($HOME.'/.vim/autoload/plug.vim'))
		exec "!curl -fLo ".$HOME.'/.vim/autoload/plug.vim'." --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    endif
endif
" autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  " \| PlugInstall --sync | source $MYVIMRC
  " \| endif
source ~/dotfiles/vim/settings.vim
source ~/dotfiles/vim/plugins.vim
" if empty(glob('~/.vim/autoload/plug.vim'))
  " silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	" \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
