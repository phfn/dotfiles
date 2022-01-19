lua << EOF
require'cmp'.setup { sources = { { name = 'path' } } }
require('nvim-autopairs').setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.rust_analyzer.setup{}
 -- remember to 'pip install python-lsp-black'
require'lspconfig'.pylsp.setup{ settings = { pylsp = { plugins = {
	pycodestyle = { enabled = false },
	pyflakes = { enabled = false },
	pylint = {
		enabled = true,
		args = { "--max-line-length=88", }
	},
}}}}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.cssls.setup{}
--require'lspconfig'.java_language_server.setup{cmd={"/usr/share/java/java-language-server/lang_server_linux.sh"} }
require'lspconfig'.java_language_server.setup{cmd={"java-language-server"} }

EOF
lua << EOF
local nvim_lsp = require('lspconfig')




-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
	mapping = {
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<C-e>'] = cmp.mapping.close(),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources(
		{ { name = 'nvim_lsp' }, },
		{ { name = 'nvim_lua' }, },
		{ { name = 'vsnip' }, },
		{ { name = 'cmdline' }, },
		{ { name = 'buffer' }, },
		{ { name = 'path' }, }
	),
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	snippet = {
		  expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		  end,
	},
experimental = {
	ghost_text = true
	}

})
local on_attach = function(client, bufnr)
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=false }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
end

vim.diagnostic.config({
	underline = {severity = {min=vim.diagnostic.severity.WARN} },
	virtual_text = {severity = {min=vim.diagnostic.severity.WARN} },
	float = {source = "always"},
	severity_sort = true
	})
EOF
