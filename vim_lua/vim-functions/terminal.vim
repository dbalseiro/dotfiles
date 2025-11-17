""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TERMINAL MODE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! MapTerm tnoremap <Esc> <C-\><C-n>
command! UnMapTerm tunmap <Esc>
MapTerm
au TermOpen * setlocal nonumber norelativenumber

"""""""""
" SHIMS "
"""""""""
nmap ,gf ,.<c-w>F<c-w>H:vertical resize +18<cr><c-l>A<esc><esc><c-h>
nmap ,n <c-l>{j,gfzz
nmap <c-leftmouse> <leftmouse>,gf

" test bash scripts
nnoremap ,t :w\|!./%<CR>

function! Terminal()
  exec ":T ghcid -c 'stack repl'"
  exec ":vsplit"
  normal <c-r>
  exec ":vertical resize +18"
  " go to the previous buffer
  normal ,,
  normal <c-w>r
endfunction

command! Terminal call Terminal()

function! HReloadAndTest()
  exec ":w"
  exec ":T:r"
  exec ":T hspec spec"
endfunction
nnoremap ,ht :call HReloadAndTest()<cr>
nnoremap ,hl :w\|T:l %<cr>
nnoremap ,hr :w\|T:r<cr>
nnoremap ,hb :w\|T stack build --fast<cr>
nnoremap ,hB :w\|T stack test<cr>

command! -bar -bang -range=0 Tcancel
      \ call neoterm#kill({ 'target': <count> })

nnoremap ,r :w\|T !!<cr>
nnoremap ,R :w\|Tcancel\|T !!<cr>


