local M = {}

function M.setup()
  vim.opt.background = "dark"
  -- vim.opt.background = "light"
  -- vim.cmd "colorscheme dayfox"
  -- require('onedark').setup {
  --  style = 'cool'
  -- }
  -- require('onedark').load()
  -- require('nightfox').setup({
  --   options = {
  --     styles = {
  --       comments = "italic",
  --       keywords = "bold",
  --       types = "bold,italic",
  --     }
  --   }
  -- vim.cmd "colorscheme github_dark"
  vim.cmd "colorscheme onedark"
  vim.cmd [[
    augroup schema_ft
      au!
      autocmd BufNewFile,BufRead *.schema set ft=graphql
    augroup END
  ]]
end

return M
