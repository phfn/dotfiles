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
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'

" Enable Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"let it look like intellij
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
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
nnoremap <leader>f<leader> :Telescope git_files<CR>
nnoremap <leader>fv :Telescope git_files cwd=~/dotfiles/<CR>
nnoremap <leader>fb :Telescope buffers<CR><ESC>k
nnoremap <leader>F :Telescope find_files<CR>
nnoremap <leader>fr :Telescope oldfiles<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>ft :Telescope builtin<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>fs <cmd>Telescope grep_string<CR><ESC>
nnoremap z= <cmd>Telescope spell_suggest<CR><ESC>
nnoremap "" <cmd>Telescope registers<CR><ESC>

" autoclose ()[]{}
Plug 'jiangmiao/auto-pairs'

" comments things
Plug 'tpope/vim-commentary'
nmap <leader>c<leader> <Plug>CommentaryLine
vmap <leader>c<leader> <Plug>Commentary
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

" flex syntax
Plug 'justinmk/vim-syntax-extra'

call plug#end()

colorscheme darcula
" transparant backgroud
hi Normal guibg=NONE ctermbg=NONE


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
