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
    move_in_saga = { prev='<up>', next='<down>'},
    definition_action_keys = { edit = '<cr>'},
  }

  local keymap = vim.keymap
  local on_attach = function(client, bufnr)
    local opts = {
      noremap = true,
      silent = true,
      buffer = bufnr
    }

    mapping = {
      ["gf"] = "Lspsaga finder",
      ["gd"] = "lua vim.lsp.buf.definition()",
      ["gD"] = "Lspsaga peek_definition:",
      ["<space>a"] = "Lspsaga code_action",
      ["<space>r"] = "Lspsaga rename",
      ["<space>d"] = "Lspsaga show_workspace_diagnostics",
      ["K"] = "Lspsaga hover_doc",
    }
    for k, cmd in pairs(mapping) do
      keymap.set("n", k, "<cmd>"..cmd.."<cr>", opts)
    end
  end

  lspconfig["pyright"].setup {
    on_attach = on_attach
  }
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
