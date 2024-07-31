"re-set the leader key for sonme reason
let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check if the dir exists before creating a file (and ask for creation)   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

  function! s:starts_with(haystack, needle)
    return a:haystack[0:len(a:needle)-1] ==# a:needle
  endfunction

  function! s:confirm(dir)
    if s:starts_with(a:dir, "oil:")
      return v:false
    else
      return input("'" . a:dir . "' Create? [y/N]") =~? '^y\%[es]$'
    endif
  endfunction

  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || s:confirm(a:dir))
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DUPLICATE CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DuplicateFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    redraw!
    return 0
  endif
  return 1
endfunction
map <leader>d :call DuplicateFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let status = DuplicateFile()
  if status == 0
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <space>r :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember cursor position between vim sessions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   execute "normal! g'\"" |
  \ endif

"^ center buffer around cursor when opening file
autocmd BufRead * normal zz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RETAB the whole file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToTabs()
  set tabstop=2
  set noexpandtab
  %retab!
endfunction
command! ToTabs call ToTabs()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EOL trimming stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autotrim = v:true

function! PrintAutotrimStatus()
  if g:autotrim
    echo "Autotrim is now ON"
  else
    echo "Autotrim is now OFF"
  endif
endfunction

function! TrimEndLines()
  let l:save_cursor = getpos(".")
  :silent! %s/\s*$//
  call setpos('.', l:save_cursor)
endfunction
nnoremap <leader>b :call TrimEndLines()<cr>

autocmd BufWritePre *
  \ if g:autotrim | call TrimEndLines() | endif

command! SwitchAutotrim let g:autotrim = !g:autotrim | call PrintAutotrimStatus()

