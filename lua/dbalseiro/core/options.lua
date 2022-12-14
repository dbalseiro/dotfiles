local opt = vim.opt

-- line numbers
opt.number = true

-- tabbing an indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.softtabstop = 2

-- I don't like text wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true

-- appearence
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "132"
opt.list = true
opt.listchars = "eol:¬,tab:▸ ,trail:·,nbsp:·"

-- misc
opt.pastetoggle = "<F2>"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

-- use emacs-style tab completion when selecting files, etc and
-- make tab completions for files/buffers act like bash
opt.wildmode = "longest,list"
opt.wildmenu = true
