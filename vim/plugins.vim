" autoload config changes on write
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.vim source $MYVIMRC | PackerCompile
augroup end

lua <<EOF
-- autoinstall packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
-- lsp
	use {'neovim/nvim-lspconfig',
		config = function() 
			vim.cmd([[source ~/dotfiles/vim/lsp.lua]])
			require("mason").setup()
			require("fidget").setup()
		end,
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			},
	}
	use {'hrsh7th/cmp-nvim-lsp'}
	use {'hrsh7th/cmp-buffer'}
	use {'hrsh7th/nvim-cmp'}
	use {'L3MON4D3/LuaSnip',
	config = vim.cmd([[
		inoremap <silent> <C-L> <cmd>lua require'luasnip'.jump(1)<Cr>
		snoremap <silent> <C-L> <cmd>lua require('luasnip').jump(1)<Cr>
		inoremap <silent> <C-H> <cmd>lua require'luasnip'.jump(-1)<Cr>
		snoremap <silent> <C-H> <cmd>lua require('luasnip').jump(-1)<Cr>
	]])
	}
	use {'saadparwaiz1/cmp_luasnip'}
	use {'hrsh7th/cmp-path'}
	use {'hrsh7th/cmp-cmdline'}
	use {'hrsh7th/cmp-nvim-lua'}


-- Enable Treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() require'nvim-treesitter.configs'.setup {
			ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
			context_commentstring = {
				enable = true,
				enable_autocmd = false
			}
		} end
	}

	use {'nvim-treesitter/nvim-treesitter-context',
		config= function() require'treesitter-context'.setup{
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the 'default' entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					'class',
					'function',
					'method',
					'for',
					'while',
					'if',
					'switch',
					'case',
				},
				-- Patterns for specific filetypes
				-- If a pattern is missing, *open a PR* so everyone can benefit.
				tex = {
					'chapter',
					'section',
					'subsection',
					'subsubsection',
				},
				rust = {
					'impl_item',
					'struct',
					'enum',
				},
				scala = {
					'object_definition',
				},
				vhdl = {
					'process_statement',
					'architecture_body',
					'entity_declaration',
				},
				markdown = {
					'section',
				},
				elixir = {
					'anonymous_function',
					'arguments',
					'block',
					'do_block',
					'list',
					'map',
					'tuple',
					'quoted_content',
				},
				json = {
					'pair',
				},
				yaml = {
					'block_mapping_pair',
				},
			},
			exact_patterns = {
				-- Example for a specific filetype with Lua patterns
				-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
				-- exactly match "impl_item" only)
				-- rust = true,
			},

			-- [!] The options below are exposed but shouldn't require your attention,
			--     you can safely ignore them.

			zindex = 20, -- The Z-index of the context window
			mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
		}
	end
	}

-- colorschemes
	use {'chiendo97/intellij.vim',
		config = vim.cmd([[" colorscheme intellij]])
	}
	use {'doums/darcula',
		config = vim.cmd([[" colorscheme darcula]])
	}
	use {'shaunsingh/solarized.nvim',
		config = vim.cmd([[" colorscheme solarized]])
	}
	use {'ellisonleao/gruvbox.nvim', 
		config = vim.cmd([[
		set background=light
		colorscheme gruvbox
		]])
	} 

--better filetree
	use {'kyazdani42/nvim-tree.lua',
	config = function()
		vim.cmd([[
			let g:nvim_tree_quit_on_open = 1
			nnoremap <leader>t<leader> :NvimTreeToggle<CR>
		]])
		require'nvim-tree'.setup {
			update_cwd = false,
			-- TODO diagnostics dont work currently
			-- diagnostics = {
				-- enable = true,
				-- icons = {
					-- hint = "",
					-- info = "",
					-- warning = "",
					-- error = ""
					-- }
					-- },
					update_focused_file = {
					enable      = true,
					update_cwd  = true,
					ignore_list = {}
					},
				view = {
					-- TODO edit mappings
					mappings = {
						custom_only = false,
						list = {}
						}
					},
				filters = {
					dotfiles = true,
					custom = {}
				}
			}
			vim.cmd([[
			]])
		end
	}

--git in filetree
	use {'Xuyuanp/nerdtree-git-plugin'}

--icons in filetree
	use {'tiagofumo/vim-nerdtree-syntax-highlight'}
	use {'ryanoasis/vim-devicons'}
	use {'kyazdani42/nvim-web-devicons'}

-- better search
	--use {'nvim-lua/plenary.nvim'}
	use {'nvim-telescope/telescope.nvim',
		requires ={ 'nvim-lua/plenary.nvim'},
		config = vim.cmd([[
				nnoremap <leader>f<leader> :Telescope git_files<CR>
				nnoremap <leader>fv :Telescope git_files cwd=~/dotfiles/<CR>
				nnoremap <leader>fb :Telescope buffers<CR><ESC>k
				nnoremap <leader>F :Telescope find_files<CR>
				nnoremap <leader>fr :Telescope oldfiles<CR>
				nnoremap <leader>fg :Telescope live_grep<CR>
				nnoremap <leader>ft :Telescope builtin<CR>
				nnoremap <leader>fh :Telescope help_tags<CR>
				nnoremap <leader>fs <cmd>Telescope grep_string<CR><ESC>
				nnoremap <leader>ff :Telescope lsp_document_symbols<CR>
				nnoremap <leader>fF :Telescope lsp_workspace_symbols<CR>
				nnoremap z= <cmd>Telescope spell_suggest<CR><ESC>
				nnoremap "" <cmd>Telescope registers<CR><ESC>
				]])
	}

-- autoclose ()[]{}
-- require('nvim-autopairs').setup{}
	use {'windwp/nvim-autopairs'}

-- comments things
	use {'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup {
				pre_hook = function(ctx)
					local U = require 'Comment.utils'

					local location = nil
					if ctx.ctype == U.ctype.block then
						location = require('ts_context_commentstring.utils').get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require('ts_context_commentstring.utils').get_visual_start_location()
					end

					return require('ts_context_commentstring.internal').calculate_commentstring {
						key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
						location = location,
					}
				end,
			}
			local ft = require('Comment.ft')
			ft.set('spl', '// %s')
		end
	}

	use {'JoosepAlviste/nvim-ts-context-commentstring',
		config = vim.cmd([[
			nmap <leader>c<leader> gcc
			vmap <leader>c<leader> gcc
		]])
	}


-- use s to surround
	use {'tpope/vim-surround'}

--intention with i eg dai deletes a funktion in python
	use {'michaeljsmith/vim-indent-object'}

-- Nice airline
	use {'nvim-lualine/lualine.nvim',
		config = function() require('lualine').setup() end
	}

-- better markings| mark with m[key] jump with '[key]
	use {'kshenoy/vim-signature'}

-- better syntax highlighting for python
	use {'vim-python/python-syntax'}

-- git support
	use {'tpope/vim-fugitive',
		config = vim.cmd([[
			map <leader>ga :w<CR>:Git add %<CR>
			map <leader>gA :Git add --patch %<CR>
			map <leader>gc :Git commit<CR>
			map <leader>gC :Git commit --amend<CR>
			map <leader>gs :G<CR>
			map <leader>gS :Git status<CR>
			map <leader>gp :Git push<CR>
			map <leader>gP :Git push --force
			map <leader>gdd :vert Gdiffsplit<CR>
			map <leader>gd1 :vert Gdiffsplit HEAD~1<CR>
			map <leader>gd :vert Gdiffsplit
			map <leader>gD :Gvdiffsplit!<CR>
			map <leader>get :diffget<CR>
			map <leader>gut :diffget<CR>
			map <leader>gf :diffget //2<CR>
			map <leader>gj :diffget //3<CR>
			au FileType fugitive set spell
			au FileType fugitive set spelllang=en
		]])
	}
	use {'airblade/vim-gitgutter'}
	use {'kdheepak/lazygit.nvim',
		config = vim.cmd([[
			map <leader>gg :LazyGit<CR>
		]])
	}

	use {'sindrets/diffview.nvim',
		 config = vim.cmd([[
			" source ~/dotfiles/vim/diff.vim
		 ]])
	}

-- vim in firefox
	use { 'glacambre/firenvim',
		run = function() vim.fn['firenvim#install'](0) end,
		config = vim.cmd([[
			source ~/dotfiles/vim/firenvim_settings.vim
		]])
	}

-- better js syntac highlighting
	use {'yuezk/vim-js'}

-- react highlighting
	use {'MaxMEllon/vim-jsx-pretty'}

-- intention lines
	use {'Yggdroot/indentLine'}

-- flex syntax
	use {'justinmk/vim-syntax-extra'}

--rust shit
	use {'simrat39/rust-tools.nvim',
		config = function() require('rust-tools').setup({}) end
	}


	use {'mfussenegger/nvim-jdtls'}

	use {'tami5/lspsaga.nvim', 
		config = function() require'lspsaga'.setup {
			code_action_keys = {
				quit = "<ESC>"
			},
			finder_action_keys = { 
				quit = "<ESC>"
			},
			-- rename_action_keys = { 
				-- quit = "<ESC>"
				-- }
		} end
	}
	use {'norcalli/nvim-colorizer.lua',
		config = function() require 'colorizer'.setup {
			'css';
			'javascript';
			html = {
				mode = 'foreground';
				}
			} end
	}

	use {'windwp/nvim-ts-autotag',
		config = function() require('nvim-ts-autotag').setup() end
	}

	use {'chrisbra/csv.vim'
		--[[ config = function() require('nvim-ts-autotag').setup() end ]]
	}

	use {'gburca/vim-logcat'
	}

	use {'amrbashir/nvim-docs-view',
		config = function() require("docs-view").setup {
		  position = "right",
		  width = 60
		}end
	}
	use{ "iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

EOF


" transparant backgroud
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
set signcolumn=auto:1-2
