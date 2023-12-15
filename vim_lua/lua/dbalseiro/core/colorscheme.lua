local M = {}

function M.setup()
  vim.opt.background = "dark"
  -- vim.opt.background = "light"
  vim.cmd "colorscheme catppuccin-frappe"

  -- Juvo schema files look like graphql
  vim.cmd [[
    augroup schema_ft
      au!
      autocmd BufNewFile,BufRead *.schema set ft=graphql
    augroup END
  ]]
  -- vim.cmd [[
  --   " transparent background
  --   hi Normal guibg=NONE ctermbg=NONE
  --   hi NormalNC guibg=NONE ctermbg=NONE
  -- ]]
end

return M
