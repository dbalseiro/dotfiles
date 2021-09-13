autocmd!

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'pangloss/vim-javascript'

Plug 'nvie/vim-togglemouse'

Plug 'vim-python/python-syntax'
Plug 'jparise/vim-graphql'
Plug 'nvie/vim-flake8'
Plug 'flebel/vim-mypy', { 'for': 'python', 'branch': 'bugfix/fast_parser_is_default_and_only_parser' }

Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'pbrisbin/vim-syntax-shakespeare'
" Plug 'vmchale/dhall-vim'
" Plug 'LnL7/vim-nix'

Plug 'schickling/vim-bufonly'

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'lepture/vim-jinja'
Plug 'kassio/neoterm'

Plug 'bling/vim-airline', { 'tag': 'v0.9' }
Plug 'vim-airline/vim-airline-themes'

Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

"LANGUAGE SERVER
let g:LanguageClient_serverCommands = {
  \ 'haskell': ['haske-language-server-8.8.4', '--lsp'],
  \ }

" restart Language Client
nnoremap <leader>0 :LanguageClientStop<cr>:LanguageClientStart<cr>

"let g:LanguageClient_diagnosticsSignsMax = 0

" enable autocomplete
let g:deoplete#enable_at_startup = 1

"if has('nvim')
    "let $VISUAL = 'nvr -cc split --remote-wait'
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=80,132
set list
set listchars=eol:¬,tab:▸\ ,trail:·,nbsp:·
set termguicolors
set background=dark
colorscheme one
" hi! Normal guibg=#abcdef ctermbg=1
" 
"delete trailing
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

function! BackSpaceDiego()
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
nnoremap <silent> <bs> :call BackSpaceDiego()<cr>

set noswapfile
set pastetoggle=<F2>
set nowrap "dont like wrapping
set mouse=a

" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
" give more space to display messages
set cmdheight=2
set switchbuf=useopen
set showtabline=2
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd

" Having longer update time (default is 4000ms) leads to noticeable delays and
" poor user experience
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the sign column, otherwise it would shift the text each time
" diagnostics appear/become visible
if has("patch-8.1.1564")
  " Recently vim can mege signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Enable highlighting for syntax
syntax enable
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <silent> <leader><cr> :nohlsearch\|let @/=""<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>
nnoremap <leader>. :only<cr>

" Language server Mappings
nnoremap <leader>] :call LanguageClient_textDocument_definition()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :tabnew\|:edit %%<cr>

"""""""""""""""""""""
" TAB MAPS:
""""""""""""""""""""""
noremap <leader>B :tabnew<cr>
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

"""""""""""""""""""""
" SPLIT MAPS:
""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>S :split\|:edit %%<cr>
map <leader>s :vsplit\|:edit %%<cr>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-s> <c-w><s-t>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY:
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! InsertTabWrapper()
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '\k'
"     return "\<tab>"
"   else
"     return "\<c-p>"
"   endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" " Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

let g:coc_start_at_startup = v:false

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DIAGNOSTICS                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check if the dir exists before creating a file (and ask for creation)   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input("'" . a:dir . "' Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DUPLICATE CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DuplicateFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    redraw!
  endif
endfunction
map <leader>d :call DuplicateFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  call DuplicateFile()
  exec ':silent !rm ' . old_name
  redraw!
endfunction
map <leader>r :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LINE NUMBERS:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber
set number

function! ToggleNumbersOn()
  set relativenumber!
  set number
endfunction

function! ToggleRelativeOn()
  set number!
  set relativenumber
  set number
endfunction

autocmd FocusLost   * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd FocusGained * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd InsertEnter * if &buftype != 'terminal' | call ToggleNumbersOn() | endif
autocmd InsertLeave * if &buftype != 'terminal' | call ToggleNumbersOn() | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EASY EDITING VIMRC:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w!\|so $MYVIMRC<CR>
nnoremap <silent> <leader>l :w!\|source %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TERMINAL MODE:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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
au BufWritePre *.re call LanguageClient_textDocument_formatting()

"""""""""""
" AIRLINE "
"""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme = 'one'
" let g:airline_theme = 'papercolor'
"
"""""""
" FZF "
"""""""
function! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfunction

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function GoToRoot()
  cd `=s:find_git_root()`
endfunction

nnoremap <C-p> :call FzfOmniFiles()<CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --ignore-file tags --column --line-number --no-heading --fixed-strings --ignore-case  --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).' '.s:find_git_root(), 1, <bang>0)
nnoremap <leader>F :execute "Find " . shellescape(expand("<cWORD>"))<cr>
nnoremap \ :call GoToRoot()\|Find<space>

nnoremap ; :Buffers<cr>
nnoremap ' :Tags<cr>

function! GenerateTags()
  cd `=s:find_git_root()`
  return system('hasktags --ctags .')
endfunction
command! GenerateTags :call GenerateTags()


"""""""
" GIT "
"""""""
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gh :!tig %<cr>
nnoremap <leader>gv :!tig<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gl :Gpull<cr>

"""""""""
" netrw "
"""""""""
" Toggle Vexplore with ctr-n
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      "exec expl_win_nr . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <c-n> :call ToggleVExplorer()<cr>
"Hit enter in the file browser to open the selected file with vsplit to the
"right of the browser
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"default to tree mode
let g:netrw_liststyle = 0
"change directory to the current buffer when opening files
set autochdir

let g:nnn#replace_netrw = 0

"""""""""
" SHIMS "
"""""""""

nmap <leader>gf ,.<c-w>F<c-w>H:vertical resize +20<cr>
nmap <c-leftmouse> <leftmouse>,gf

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json sel formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nnoremap <silent><nowait> <space>a :CocAction<cr>

""""""""""""""""""""""
" Show Documentation "
""""""""""""""""""""""
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand(<cword>)
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand(<cword>)
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

""""""""""""""""""""""""""""""
" Haskell syntax highligying "
""""""""""""""""""""""""""""""
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keys

nnoremap <c-up> :cd ..<cr>

"""""""""""
" HINDENT "
"""""""""""
let g:hindent_on_save = 0 "manually indent hs files

" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" Key bindings
augroup haskellStylish
  au!
  " Just hindent
  au FileType haskell nnoremap <leader>hi :Hindent<CR>
  " Just stylish-haskell
  au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
  " First hindent, then stylish-haskell
  au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
augroup END

let g:ale_linters = { 'haskell': ['hlint'], 'python': ['flake8'], 'javascript': ['jslint']}

" test bash scripts
nnoremap <leader>t :w\|!./%<CR>

"run mypy
function! MyPyDiego() 
  set makeprg=mypy
  make --ignore-missing-imports --follow-imports=skip %
endfunction

nnoremap <leader>mp :call MyPyDiego()<cr>

function! Terminal()
  exec ":T cd .."
  exec ":vsplit"
  exec ":vertical resize +20"
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

nnoremap <leader>r :w\|T !!<cr>

" Sane Remappings
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
inoremap <c-j> <esc>:m .+1<cr>==i
inoremap <c-k> <esc>:m .-2<cr>==i
nnoremap <leader>j :m .+1<cr>==
nnoremap <leader>k :m .-2<cr>==
