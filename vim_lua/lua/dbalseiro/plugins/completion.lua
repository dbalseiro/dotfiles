local M = {}

function M.setup()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<cr>"] = cmp.mapping.confirm({ select = true }),
      ["<esc>"] = cmp.mapping.abort()
    }),
    sources = cmp.config.sources {
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "buffer" },
      { name = "path" },
    },
    formatting = {
      format = lspkind.cmp_format {
        maxwidth = 50,
        ellipsis_char = "..."
      }
    }
  }
end

return M
