
let g:firenvim_config = { 
	\ 'globalSettings': {
		\ 'takeover': 'never',
		\ 'ignoreKeys': {
			\ 'all': ['<F5>', '<C-l>'],
		\ }
	\ },
    \'localSettings':{}
\ }
let fc = g:firenvim_config['localSettings']
let fc['.*'] = {'takeover': 'never', 'selector': 'textarea'}
let fc['https://pastebin.com'] = {'takeover': 'always'}
let fc['https://colab.research.google.com'] = {'takeover': 'always'}
let fc['http://localhost:8888'] = {'takeover': 'always'}

if exists('g:started_by_firenvim')
  au TextChanged * ++nested write
  au TextChangedI * ++nested write
  map <Esc> :q<CR>
  au BufEnter * CocDisable
  au BufEnter colab.research.google.com_*.txt set filetype=python
endif
