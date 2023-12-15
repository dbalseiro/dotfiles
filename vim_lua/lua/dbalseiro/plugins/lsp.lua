local M = {}

function M.setup()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local lspsaga = require("lspsaga")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  mason.setup {
    pip = {
      upgrade_pip = true
    }
  }

  mason_lspconfig.setup {
    ensure_installed = { "hls", "pyright" }
  }
  lspconfig.hls.setup({})
  lspconfig.pyright.setup({})

  lspsaga.setup {
    move_in_saga = { prev = '<up>',next = '<down>'},
    definition_action_keys = { edit = '<cr>'},
  }

  local keymap = vim.keymap
  local on_attach = function(client, bufnr)
    local opts = {
      noremap = true,
      silent = true,
      buffer = bufnr
    }
    keymap.set("n", "gf", "<cmd>Lspsaga finder<cr>", opts)
    keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", opts)
    keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<cr>", opts)
    keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>", opts)
    keymap.set("n", "<space>d", "<cmd>Lspsaga show_workspace_diagnostics<cr>", opts)
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
  end

  lspconfig["hls"].setup {
    capabilities = cmp_nvim_lsp.default_capabilities(),
    on_attach = on_attach
  }
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
      },
      signs = true,
    }
  )

  local lint = require'lint'
  vim.cmd([[
    autocmd CursorHold * lua vim.diagnostic.open_float()
  ]])

  -- how long it will take to show the error popup (in miliseconds)
  vim.opt.updatetime = 500

  -- setup hlint
  lint.linters_by_ft = {
    haskell = {'hlint'}
  }

  vim.cmd([[
    autocmd BufWritePost * lua require('lint').try_lint()
  ]])

end

return M
