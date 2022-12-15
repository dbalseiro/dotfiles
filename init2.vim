Plug 'kassio/neoterm'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TERMINAL MODE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! MapTerm tnoremap <Esc> <C-\><C-n>
command! UnMapTerm tunmap <Esc>
MapTerm
au TermOpen * setlocal nonumber norelativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember cursor position between vim sessions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g'\"" |
  \ endif
autocmd BufRead * normal zz
"^ center buffer around cursor when opening file

function! TrimEndLines()
  let save_cursor = getpos(".")
  :silent! %s/\s*$//
  call setpos('.', save_cursor)
endfunction
nnoremap <leader>b :call TrimEndLines()<cr>
" au BufWritePre * call TrimEndLines()

let g:nnn#replace_netrw = 0

"""""""""
" SHIMS "
"""""""""

nmap <leader>gf ,.<c-w>F<c-w>H:vertical resize +18<cr>
nmap <c-leftmouse> <leftmouse>,gf


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" test bash scripts
nnoremap <leader>t :w\|!./%<CR>

function! Terminal()
  exec ":T cd .."
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

nnoremap <leader>R :call neoterm#exec("\<C-c>")<cr>

command! -bar -bang -range=0 Tcancel
      \ call neoterm#kill({ 'target': <count> })

nnoremap <leader>r :w\|T !!<cr>
nnoremap <leader>R :w\|Tcancel\|T !!<cr>

augroup schema_ft
  au!
  autocmd BufNewFile,BufRead *.schema set syntax=graphql
augroup END
