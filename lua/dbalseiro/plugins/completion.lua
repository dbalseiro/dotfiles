local M = {}

function M.setup()
  --local status, cmp = pcall(require, "cmp")
  --local statusk lspkind = pcall(require, "lspkind")

  --if not status or not statusk then
    --return
  --end
  cmp = require("cmp")
  -- lspkind = require("lspkind")

  vim.opt.completeopt = "menu,menuone,noselect"
  cmp.setup {
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
      ["<down>"] = cmp.mapping.select_next_item(),
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<up>"] = cmp.mapping.select_prev_item(),
      ["<cr>"] = cmp.mapping.confirm({ select = false }),
      ["<esc>"] = cmp.mapping.abort()
    },
    sources = cmp.config.sources {
    --  { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" }
    },
    -- formatting = {
    --   format = lspkind.cmp_format {
    --       maxwidth = 50,
    --       ellipsis_char = "..."
    --   }
    -- }
  }
end

return M
