local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- visual niceties
  use {
    'folke/tokyonight.nvim',
    branch = 'main'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { { 'nvim-tree/nvim-web-devicons' } },
    config = require'dbalseiro.plugins.lualine'.setup()
  }

  use {
    'lewis6991/gitsigns.nvim',
    -- config = function()
    --   require'gitsigns'.setup()
    -- end
  }

  -- telescope and tags (and telescoped tags)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} },
    -- config = function()
    --   require'dbalseiro.plugins.telescope'.setup()
    -- end
  }
  use {
    'szw/vim-tags',
    -- config = function()
    --   require'dbalseiro.plugins.vim-tags'.setup()
    -- end
  }

  -- editing essentials
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'godlygeek/tabular'

  -- TREESITER
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    -- config = require'nvim-treesitter.configs'.setup {
    --   -- A list of parser names, or "all"
    --   ensure_installed = { "haskell" },
    --   -- Install parsers synchronously (only applied to `ensure_installed`)
    --   sync_install = false,
    --   -- Automatically install missing parsers when entering buffer
    --   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    --   auto_install = false,
    --   highlight = {
    --     -- `false` will disable the whole extension
    --     enable = true,
    --     additional_vim_regex_highlighting = true,
    --   },
    -- }
  }

  -- COMPLETION
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      -- { "onsails/lspkind.nvim" }
    },
    -- config = require'dbalseiro.plugins.completion'.setup()
  }

  -- LSP
  -- use {
  --   "neovim/nvim-lspconfig",
  --   requires = {
  --     { "williamboman/mason.nvim" },
  --     { "williamboman/mason-lspconfig.nvim" },
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "glepnir/lspsaga.nvim", branch = "main" },
  --   },
  --   config = require'dbalseiro.plugins.lsp'.setup()
  -- }

  if packer_bootstrap then
    require'packer'.sync()
  end
end)