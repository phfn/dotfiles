let g:firenvim_config = {
	\ 'globalSettings': {
		\ 'ignoreKeys': {
			\ 'all': ['<F5>', '<C-l>'],
		\ }
	\ },
    \'localSettings':{
		\ '.*': { 'takeover': "never", 'selector': "textarea", 'priority': 0 },
		\ 'https://colab.research.google.com': { 'takeover': "always", 'priority': 1 },
		\ 'http://localhost:8888': { 'takeover': "always", 'priority': 1 },
	\ }
\ }
function! SetUpFirenvim()
	" colorscheme intellij
	map <Esc> :q<CR>
	set noshowmode
	set noruler
	set laststatus=0
	set noshowcmd
	set signcolumn=no
	set nonumber
	set norelativenumber
	lua vim.diagnostic.config({ underline = false, virtual_text = false })

endfunction
if exists('g:started_by_firenvim')
	au TextChanged * ++nested write
	au TextChangedI * ++nested write
	au BufEnter colab.research.google.com_*.txt set filetype=python
	au BufEnter localhost_*-ipynb*.txt set filetype=python
	au BufEnter * call SetUpFirenvim()
endif
