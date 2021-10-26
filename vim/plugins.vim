""install Plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin()
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-path'

" let it look like intellij
Plug 'doums/darcula'

" Another colorscheme
Plug 'morhetz/gruvbox'

"better filetree
Plug 'preservim/nerdtree'
map <leader>t :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

"git in filetree
Plug 'Xuyuanp/nerdtree-git-plugin' 

"icons in filetree
 Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
 Plug 'ryanoasis/vim-devicons'

" better search 
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" autoclose ()[]{}
Plug 'jiangmiao/auto-pairs'

" comments things
Plug 'tpope/vim-commentary'
map <leader>c<leader> <Plug>CommentaryLine
" Plug 'preservim/nerdcommenter'
" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1


" use s to surround
Plug 'tpope/vim-surround'

"intention with i eg dai deletes a funktion in python
Plug 'michaeljsmith/vim-indent-object'

"venv shit | use :VirtualEnvActivate venv
Plug 'jmcantrell/vim-virtualenv'

"autosafe with :AutoSaveToggle
Plug '907th/vim-auto-save'
let g:auto_save = 0
au FileType python let b:auto_save = 1
au FileType javascript let b:auto_save = 1
au FileType rust let b:auto_save = 1
au FileType markdown let b:auto_save = 1

" Nice airline
Plug 'vim-airline/vim-airline'

" better markings| mark with m[key] jump with '[key]
Plug 'kshenoy/vim-signature'

" better syntax highlighting for python
Plug 'vim-python/python-syntax'

" git support
Plug 'tpope/vim-fugitive'
map <leader>ga :Git add %<CR> 
map <leader>gc :Git commit<CR> 
map <leader>gs :G<CR> 
map <leader>gS :Git status<CR> 
map <leader>gp :Git push<CR> 
map <leader>gd :vert Gdiffsplit<CR>
map <leader>gD :Gvdiffsplit!<CR>
map <leader>get :diffget<CR>
map <leader>gf :diffget //2<CR>
map <leader>gj :diffget //3<CR>
au FileType set spell<CR>

" vim in firefox
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
source ~/dotfiles/vim/firenvim_settings.vim

" better js syntac highlighting
Plug 'yuezk/vim-js'

" react highlighting
Plug 'MaxMEllon/vim-jsx-pretty'

" intention lines
Plug 'Yggdroot/indentLine'

Plug 'jremmen/vim-ripgrep'

Plug 'justinmk/vim-syntax-extra'
call plug#end()

colorscheme darcula
" transparant backgroud
hi Normal guibg=NONE ctermbg=NONE

map <leader>f :GFiles<CR>
map <leader>F :Files<CR>

" lsp config
source /home/phfn/dotfiles/vim/lsp.vim
let g:vsnip_filetypes = {}
