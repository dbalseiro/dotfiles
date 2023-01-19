local M = {}

function M.setup()
  vim.opt.background = "dark"

  require('onedark').setup {
    style = 'cool'
  }
  require('onedark').load()

  vim.cmd [[
    augroup schema_ft
      au!
      autocmd BufNewFile,BufRead *.schema set ft=graphql
    augroup END
  ]]
end

return M
