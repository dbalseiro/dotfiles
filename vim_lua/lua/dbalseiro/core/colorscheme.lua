vim.opt.background = "dark"
local scheme = "tokyonight"

local status, _ = pcall(vim.cmd, "colorscheme "..scheme)
if not status then
  print("Color Scheme: "..scheme.." not found")
end

vim.cmd [[
  augroup schema_ft
    au!
    autocmd BufNewFile,BufRead *.schema set ft=graphql
  augroup END
]]
