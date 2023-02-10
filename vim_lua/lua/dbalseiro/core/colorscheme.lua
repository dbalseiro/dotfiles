local M = {}

function M.setup()
  vim.opt.background = "dark"
  vim.cmd "colorscheme nightfox"
  -- require('onedark').setup {
  --   style = 'cool'
  -- }
  -- require('onedark').load()
  require('nightfox').setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "bold,italic",
      }
    }
  })

  vim.cmd [[
    augroup schema_ft
      au!
      autocmd BufNewFile,BufRead *.schema set ft=graphql
    augroup END
  ]]
end

return M
