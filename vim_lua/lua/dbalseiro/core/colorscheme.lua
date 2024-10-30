local M = {}

function M.setup()
  -- Check the OS's theme to change between light and dark
  local handle = io.popen("sw info")
  local result = handle:read("*a")
  handle:close()
  vim.opt.background = result == "BreezeLight" and "light" or "dark"
  vim.cmd "colorscheme catppuccin"

  -- Juvo schema files look like graphql
  vim.cmd [[
    augroup schema_ft
      au!
      autocmd BufNewFile,BufRead *.schema set ft=graphql
    augroup END
  ]]
end

return M
