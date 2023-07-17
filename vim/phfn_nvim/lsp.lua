local set_lsp_keybindings = function(client, bufnr)
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=false }
	print("lsp.lua")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>r<space>', '<cmd>Lspsaga rename<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>Lspsaga code_action<CR>', opts)
	buf_set_keymap('x', '<space>ca', '<cmd>Lspsaga range_code_action<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
	buf_set_keymap('n', '<space>Q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	buf_set_keymap("n", "<ESC>", "<cmd>Lspsaga close_floaterm<cr>", opts)
	buf_set_keymap("n", "<space>fu", "<cmd>Lspsaga lsp_finder<cr>", opts)

end
local set_lsp_keybindings2 = function(client) set_lsp_keybindings(client, 0)end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local server_settings = {
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					pylint = {
						enabled = true,
						args = { "--max-line-length=88", }
					},
				}
			}
		},
	},
}

require 'mason-lspconfig'.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = set_lsp_keybindings2,
      settings = server_settings[server_name],
    }
  end,
}

-- Setup nvim-cmp.
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require'cmp'
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp.setup({
	snippet = {
		  expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		  end,
	},
	mapping = cmp.mapping.preset.insert({
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<C-e>'] = cmp.mapping.close(),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
	  ['<C-q>'] = cmp.mapping.confirm {
		  behavior = cmp.ConfirmBehavior.Insert,
		  select = true,
		  },
	  ["<Tab>"] = cmp.mapping(function(fallback)
		  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
		  if cmp.visible() then
			  local entry = cmp.get_selected_entry()
			  if not entry then
				  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			  else
				  cmp.confirm()
			  end
		  elseif require'luasnip'.expand_or_jumpable() then
			  require'luasnip'.expand_or_jump()
		  else
			  fallback()
		  end
	  end, {"i","s",}),
	}),
	sources = cmp.config.sources(
		{ { name = 'nvim_lsp' }, },
		{ { name = 'luasnip' }, },
		{ { name = 'path' }, },
		{ { name = 'buffer' }, }
	),
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	view = {
		entries = 'native'
	},
	experimental = {
		ghost_text = true
	}
})
vim.diagnostic.config({
	underline = {severity = {min=vim.diagnostic.severity.WARN} },
	virtual_text = {severity = {min=vim.diagnostic.severity.WARN} },
	float = {source = "always"},
	severity_sort = true
	})
