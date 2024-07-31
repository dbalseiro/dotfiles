local M = {}

function M.setup()
  -- require("tokyonight").setup({ style = "night" })
  vim.opt.background = "dark"
  vim.cmd "colorscheme catppuccin"
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
