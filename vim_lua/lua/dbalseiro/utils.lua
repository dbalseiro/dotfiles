local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.source_vim(fn)
  local path = os.getenv("MYVIMRC"):gsub("init%.lua$", "")
  local file = path.."lua/dbalseiro/vim-functions/"..fn..".vim"
  vim.cmd("source "..file)
end

return M
