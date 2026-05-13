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
	-- {'https://github.com/mason-org/mason.nvim', opts=function() require('mason').setup({}) end},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {'rust_analyzer', 'pylsp'},
			automatic_enable = {
				exclude = { }
			}
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons',     -- optional
		}
	},
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
	{'https://github.com/ellisonleao/gruvbox.nvim',
		opts = function()
			vim.cmd([[
				" set background=light
				colorscheme gruvbox
			]])
		end,
	},
	{'https://github.com/kyazdani42/nvim-tree.lua',
		lazy = false,
		opts = { },
		init = function() vim.cmd([[
			let g:nvim_tree_quit_on_open = 1
		]])end,
		keys = {
			{'<leader>t<leader>', "<cmd>NvimTreeToggle<cr>", desc = "Live grep"},
			{'<leader>tt', ":Telescope find_files", desc = "Find file"},
		},
	},
	{'https://github.com/tpope/vim-fugitive',
		config = function() vim.cmd([[
			au FileType fugitive set spell
			au FileType fugitive set spelllang=en
		]]) end,
		keys = { 
			{ "<leader>ga",  ":w<CR>:Git add %<CR>",        desc = "Git add current file" },
			{ "<leader>gA",  ":Git add --patch %<CR>",      desc = "Git add patch current file" },
			{ "<leader>gc",  ":Git commit<CR>",             desc = "Git commit" },
			{ "<leader>gC",  ":Git commit --amend<CR>",     desc = "Git amend commit" },
			{ "<leader>gs",  ":G<CR>",                      desc = "Git status (fugitive)" },
			{ "<leader>gp",  ":Git push<CR>",               desc = "Git push" },
			{ "<leader>gP",  ":Git push --force<CR>",       desc = "Git push force" },
			{ "<leader>gdd", ":vert Gdiffsplit<CR>",        desc = "Git vertical diff" },
			{ "<leader>gd1", ":vert Gdiffsplit HEAD~1<CR>", desc = "Git diff HEAD~1" },
			{ "<leader>gd",  ":vert Gdiffsplit<CR>",        desc = "Git diff (vert)" },
			{ "<leader>gD",  ":Gvdiffsplit!<CR>",           desc = "Git diff (vert, bang)" },
			{ "<leader>get", ":diffget<CR>",                desc = "Git diffget" },
			{ "<leader>gut", ":diffget<CR>",                desc = "Git diffget" },
			{ "<leader>gf",  ":diffget //2<CR>",            desc = "Git diffget //2" },
			{ "<leader>gj",  ":diffget //3<CR>",            desc = "Git diffget //3" },
			{ "<leader>gs",  ":G<CR>",                      desc = "Show git status" },
		}
	},
	{ 'nvim-telescope/telescope.nvim', 
		version = '0.2.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{'<leader>f<leader>', ':Telescope git_files<CR>', desc = "Find file in git"},
			{'<leader>fv', ':Telescope git_files cwd=~/dotfiles/<CR>', desc = "Find files in dotfiles"},
			{'<leader>fb', ':Telescope buffers<CR><ESC>k', desc = "Find a Buffer"},
			{'<leader>F', ':Telescope find_files<CR>', desc = "Find a file in pwd"},
			{'<leader>fr', ':Telescope oldfiles<CR>', desc = "Find a recently edited file"},
			{'<leader>fg', ':Telescope live_grep<CR>', desc = "Find a file base on grep"},
			{'<leader>ft', ':Telescope builtin<CR>', desc = "Find a Telescope function"},
			{'<leader>fh', ':Telescope help_tags<CR>', desc = "Find Help"},
			{'<leader>fs', '<cmd>Telescope grep_string<CR><ESC>', desc = "Find by Grep String"},
			{'<leader>ff', ':Telescope lsp_document_symbols<CR>', desc = "Find  LSP Symbold"},
			{'<leader>fF', ':Telescope lsp_workspace_symbols<CR>', desc = "Find LSP Workspace Symbol"},
			{'z=', '<cmd>Telescope spell_suggest<CR><ESC>', desc = "Suggest spell"},
			{'""', '<cmd>Telescope registers<CR>', desc = "Show Clipboards"}
		},
	},
	{ "folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
			{ "<leader>g", group = "Git" },
		},
	},
	{'chiendo97/intellij.vim',
		config = false
	},
	{'doums/darcula',
		config = false
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Set up lspconfig
require'phfn_nvim.lsp'
