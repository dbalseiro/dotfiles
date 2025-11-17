function! BetterBackSpace()
  if empty(getline('.'))
    " If empty line, delete it and go to the end of the top one
    execute 'normal ddk$'
  else
    " If not empty and the cursor is in the first column, umify lines with the
    " top one
    let col = col('.') - 1
    if !col
      if empty(getline(line('.') - 1))
        execute 'normal kJ'
      else
        execute 'normal kJx'
      endif
    else
      " Any other case, just backspace
      execute 'normal X'
    endif
  endif
endfunction

nnoremap <s-bs> o<esc>
nnoremap <silent> <bs> :call BetterBackSpace()<cr>


