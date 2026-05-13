local set_lsp_keybindings = function(client, bufnr)
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
vim.diagnostic.config({
	underline = {severity = {min=vim.diagnostic.severity.WARN} },
	virtual_text = {severity = {min=vim.diagnostic.severity.WARN} },
	float = {source = "always"},
	severity_sort = true
})

vim.api.nvim_create_autocmd('LspAttach', {


  callback = function(ev)
	  print("hallo")
	  vim.cmd[[set completeopt+=menuone,noselect,popup]]
	  local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
	  vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
	  vim.cmd[[inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>']]
	  set_lsp_keybindings(client, ev.buf)
	  vim.api.nvim_create_autocmd('InsertCharPre', { callback = function() vim.lsp.completion.get() end } )
  end,

})
