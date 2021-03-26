"Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" let it look like intellij
Plug 'doums/darcula'

"better filetree
Plug 'preservim/nerdtree'
map <leader>t :NERDTreeToggle<CR>

"git in filetree
Plug 'Xuyuanp/nerdtree-git-plugin' 

"icons in filetree
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'

"linter
" Plug 'vim-syntastic/syntastic'
" better than syntastics?
" Plug 'dense-analysis/ale'
" let g:ale_fixers = {'python': ['add_blank_lines_for_python_control_statements','autoimport', 'remove_trailing_lines', 'trim_whitespace']}

" better search 
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
map <leader>gf :GFiles<CR>

" autoclose ()[]{}
Plug 'jiangmiao/auto-pairs'

"comment things with space+c+space
Plug 'preservim/nerdcommenter'
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDTreeQuitOnOpen = 1

"autpcomletion in python
Plug 'davidhalter/jedi-vim'
"use s to surround
Plug 'tpope/vim-surround'

"intention with i eg dai deletes a funktion in python
Plug 'michaeljsmith/vim-indent-object'

"venv shit | use :VirtualEnvActivate venv
Plug 'jmcantrell/vim-virtualenv'

"autosafe with :AutoSaveToggle
Plug '907th/vim-auto-save'

" better markings| mark with m[key] jump with '[key]
Plug 'kshenoy/vim-signature'

" better syntax highlighting for python
Plug 'vim-python/python-syntax'

" git support
Plug 'tpope/vim-fugitive'
map <leader>ga :Git add %<CR> 
map <leader>gc :Git commit<CR> 
map <leader>gs :Git status<CR> 
map <leader>gp :Git push<CR> 
map <leader>gd :vert Gdiffsplit<CR>

call plug#end()

colorscheme darcula
