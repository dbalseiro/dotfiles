local M = {}

function M.setup()
  mason = require("mason")
  mason_lspconfig = require("mason-lspconfig")
  lspconfig = require("lspconfig")
  lspsaga = require("lspsaga")
  cmp_nvim_lsp = require("cmp_nvim_lsp")

  mason.setup()
  mason_lspconfig.setup {
    ensure_installed = { "hls" }
  }

  -- lspsaga.init_lsp_saga {
  --   move_in_saga = { prev = '<up>',next = '<down>'},
  --   definition_action_keys = { edit = {'o', '<cr>'}},
  -- }

  -- lspconfig.hls.setup({})

  -- local keymap = vim.keymap
  -- local on_attach = function(client, bufnr)
  --   local opts = {
  --     noremap = true,
  --     silent = true,
  --     buffer = bufnr
  --   }
  --   -- keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<cr>", opts)
  --   -- keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  --   -- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)
  --   -- keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<cr>", opts)
  --   -- keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>", opts)
  --   -- keymap.set("n", "<space>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
  --   -- keymap.set("n", "[d", "<cmd>Lspsaga diagnostics_show_prev<cr>", opts)
  --   -- keymap.set("n", "]d", "<cmd>Lspsaga diagnostics_show_next<cr>", opts)
  --   -- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
  -- end

  -- lspconfig["hls"].setup {
  --   capabilities = cmp_nvim_lsp.default_capabilities(),
  --   on_attach = on_attach
  -- }

end

return M
