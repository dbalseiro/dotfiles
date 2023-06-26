local utils = require 'dbalseiro.utils'

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
  use { 'projekt0n/github-nvim-theme' }
  use "EdenEast/nightfox.nvim" -- Packer
  use {
    'navarasu/onedark.nvim'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
      require'dbalseiro.plugins.lualine'.setup()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require'gitsigns'.setup()
    end
  }

  use {
      'romgrk/barbar.nvim',
      requires = { { 'nvim-tree/nvim-web-devicons' }, { 'lewis6991/gitsigns.nvim' } },
      config = function()
        require'dbalseiro.core.colorscheme'.setup()
      end
  }

  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          default_component_configs = {
            git_status = {
              symbols = {
                -- Change type
                untracked = "?",
              }
            }
          }
        })
      end
    }

  -- telescope and tags (and telescoped tags)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require'dbalseiro.plugins.telescope'.setup()
    end
  }
  use {
    'szw/vim-tags',
    config = function()
      require'dbalseiro.plugins.vim-tags'.setup()
    end
  }

  -- editing essentials
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'godlygeek/tabular'

  -- TERMINAL
  use {
    'kassio/neoterm',
    config = require("dbalseiro.utils").source_vim("terminal")
  }

  -- TREESITER
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "haskell", "graphql" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    }
  }

  -- COMPLETION
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { "onsails/lspkind.nvim" }
    },
    config = require'dbalseiro.plugins.completion'.setup()
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "glepnir/lspsaga.nvim", branch = "main" },
      { 'mfussenegger/nvim-lint' },
    },
    config = require'dbalseiro.plugins.lsp'.setup()
  }

  -- STARTUP SCREEN
  use {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
      require"startup".setup()
    end
  }

  if packer_bootstrap then
    require'packer'.sync()
  end
end)
