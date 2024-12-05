local M = {}

function M.setup()
  config = require 'todo-comments'
  config.setup {
    keywords = {
      WIP = { icon = " ", color = "warning" }
    }
  }
end

return M
