local M = {}

function M.setup()
  vim.g.vim_tags_auto_generate = 0
  vim.g.vim_tags_ctags_binary = 'hasktags'
  vim.g.vim_tags_project_tags_command = "{CTAGS} -c {DIRECTORY}"
end

return M
