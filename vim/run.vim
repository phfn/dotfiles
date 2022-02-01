au BufEnter *.py map <F9> :w <bar> !python %<CR>
au BufEnter *.py map <F19> :w <bar> !python %<Up><CR>
au BufEnter *.js map <F9> :w <bar> !node %<CR>
au BufEnter *.js map <F19> :w <bar> !node %<Up><CR>
au BufEnter *.rs map <F9> :w <bar> !cargo run<CR>
au BufEnter *.rs map <F19> :w <bar>!cargo run<Up><CR>
au BufEnter *.y map <F9> :w <bar>!bison -dtv %<CR>
au BufEnter *.sh map <F9> :w <bar>!%:p<CR>

