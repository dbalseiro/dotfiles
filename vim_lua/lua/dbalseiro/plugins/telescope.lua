local M = {}

local map = require("dbalseiro.utils").map
local builtin = require("telescope.builtin")

local function is_git()
  vim.fn.system({"git", "status"})
  return vim.v.shell_error == 0
end

function M.setup ()
  map("n", "<c-p>", function()
    if is_git() then
      builtin.git_files()
    else
      builtin.find_files()
    end
  end)

  map("n", "\\", builtin.live_grep)
  map("n", "<c-f>", builtin.grep_string)
  map("n", ";", builtin.buffers)
  map("n", "'", builtin.tags)
end

return M
