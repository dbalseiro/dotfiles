vim.g.mapleader = ","

local map = require("dbalseiro.utils").map

local k = vim.keymap

-- clear search highlighting
map("n", "<leader><cr>", ':nohlsearch|let @/=""<cr>', { silent = true })

-- quick switch to last edited buffer
map("n", "<leader><leader>", "<c-^>")
-- leave only one buffer visible
map("n", "<leader>.", ":only<cr>")

-------------------
-- TERMINAL MAPS --
-------------------
map("t", "<A-h>", '<C-\\><C-n><C-w>h')
map("t", "<A-j>", '<C-\\><C-n><C-w>j')
map("t", "<A-k>", '<C-\\><C-n><C-w>k')
map("t", "<A-l>", '<C-\\><C-n><C-w>l')
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
