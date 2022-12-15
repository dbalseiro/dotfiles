function source_vim(fn)
  local path = os.getenv("MYVIMRC"):gsub("init%.lua$", "")
  vim.cmd("source "..path.."lua/dbalseiro/vim-functions/"..fn..".vim")
end

source_vim "better-backspace"
source_vim "files-shennanigans"
