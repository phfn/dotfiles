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
if exists('g:started_by_firenvim')
  au TextChanged * ++nested write
  au TextChangedI * ++nested write
  map <Esc> :q<CR>
  au BufEnter colab.research.google.com_*.txt set filetype=python
  au BufEnter localhost_*-ipynb*.txt set filetype=python
  colorscheme intellij
  " deactivate statusline
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endif
