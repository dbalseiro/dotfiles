local M = {}

function M.setup ()
  local opts = {noremap=true, silent=true}
  local cmd = "Neotree toggle"
  vim.keymap.set("n", "=", "<cmd>"..cmd.."<cr>", opts)
end

return M
