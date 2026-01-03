-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
	{'https://github.com/mason-org/mason.nvim', opts=function() require('mason').setup({}) end},
	{'https://github.com/neovim/nvim-lspconfig' },
	{'https://github.com/nvim-treesitter/nvim-treesitter',
		opts = {
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
		}
	},
	{'https://github.com/hrsh7th/nvim-cmp',
		lazy = false,
		dependencies = {
			{'https://github.com/petertriho/cmp-git',
				dependencies = {"https://github.com/nvim-lua/plenary.nvim"},
				opts = {
					filetypes = {"*"}
				}
			},
			{'https://github.com/hrsh7th/cmp-path'},
			{'https://github.com/hrsh7th/cmp-emoji'},
		},
		opts = function()
			local cmp = require'cmp'

			return {
			snippet = {
			  expand = function(args)
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
			  end,
			},
			mapping = cmp.mapping.preset.insert({
			  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
			  ['<C-f>'] = cmp.mapping.scroll_docs(4),
			  ['<C-Space>'] = cmp.mapping.complete(),
			  ['<C-e>'] = cmp.mapping.abort(),
			  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources(
				{
					{ name = 'git' },
					{ name = 'emoji' },
					{ name = 'nvim_lsp' },
					{ name = 'path' },
					{ name = 'cmdline' },
					{ name = 'commit' },

				},
				{
					{ name = 'buffer' },
				}
			),
			}
			

		end,
	},
	{'https://github.com/hrsh7th/cmp-nvim-lsp',
		dependencies = {"nvim-cmp"},
		opts = function() 
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('pylsp', {
				capabilities = capabilities
			})
			vim.lsp.enable('pylsp')
		end
	},
	{'https://github.com/ellisonleao/gruvbox.nvim',
		opts = function()
			vim.cmd([[
				set background=light
				colorscheme gruvbox
			]])
		end,
		lazy = false
	},
	{'https://github.com/kyazdani42/nvim-tree.lua',
		lazy = false,
		keys = {
			{ "<leader>t<leader", ":NvimTreeToggle", desc = "NeoTree" },
		},
		opts = { }
	},
	{'https://github.com/tpope/vim-fugitive',
		config = function() vim.cmd([[
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
		]]) end,
	},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Set up lspconfig.
