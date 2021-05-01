

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>K :call <SID>show_help()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	call CocActionAsync('doHover')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:show_help()
	execute 'h '.expand('<cword>')
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-marketplace', 'coc-tsserver', 'coc-vimlsp', 'coc-eslint']
" autocmd 

" let g:AutoPairsFlyMode = 1

"showSignatureHelp"
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
