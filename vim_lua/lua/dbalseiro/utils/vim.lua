local M = {}

M.source_vim = function(fn)
	local path = os.getenv("MYVIMRC"):gsub("init%.lua$", "")
	local file = path .. "vim-functions/" .. fn .. ".vim"
	vim.cmd("source " .. file)
end

return M
