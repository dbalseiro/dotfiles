"reset the leader key for sonme reason
let mapleader=","

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
nmap <leader>gf ,.<c-w>F<c-w>H:vertical resize +18<cr><a-l>A<a-h>
nmap <leader>n <a-l>{j,gf
nmap <c-leftmouse> <leftmouse>,gf

" test bash scripts
nnoremap <leader>t :w\|!./%<CR>

function! Terminal()
  exec ":T ghcid -c 'stack repl'"
  exec ":vsplit"
  exec ":vertical resize +18"
  " go to the previous buffer
  normal ,,
endfunction

command! Terminal call Terminal()

function! HReloadAndTest()
  exec ":w"
  exec ":T:r"
  exec ":T hspec spec"
endfunction
nnoremap <leader>ht :call HReloadAndTest()<cr>
nnoremap <leader>hl :w\|T:l %<cr>
nnoremap <leader>hr :w\|T:r<cr>
nnoremap <leader>hb :w\|T stack build --fast<cr>
nnoremap <leader>hB :w\|T stack test<cr>

command! -bar -bang -range=0 Tcancel
      \ call neoterm#kill({ 'target': <count> })

nnoremap <leader>r :w\|T !!<cr>
nnoremap <leader>R :w\|Tcancel\|T !!<cr>


