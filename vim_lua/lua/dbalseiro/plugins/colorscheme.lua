return {
  { 'letorbi/vim-colors-modern-borland' },
  {
    'catppuccin/nvim',

    priority = 1000, -- Make sure to load this before all the other start plugins.

    name = 'catppuccin',

    dependencies = {
      'rcarriga/nvim-notify',
    },

    init = function()
      vim.cmd.hi 'Comment gui=none'
      require('catppuccin').setup {
        styles = {
          keywords = { 'bold' },
          operators = { 'bold' },
        },
        transparent_background = true,
      }
      vim.cmd.colorscheme 'catppuccin'
      -- vim.cmd.colorscheme 'borland'

      if vim.cmd.color() ~= "catppuccin" then
        local fhandle = io.popen 'sw info'
        local result = ""
        if fhandle ~= nil then
          result = fhandle:read '*a'
          fhandle:close()
        end
        vim.opt.background = result == 'BreezeDark' and 'dark' or 'light'
        if result ~= 'BreezeDark' then
          vim.cmd [[
            highlight TelescopeNormal         guibg=#eff1f5 guifg=#4c4f69
            highlight TelescopeBorder         guibg=#eff1f5 guifg=#ccd0da
            highlight TelescopePromptNormal   guibg=#e6e9ef guifg=#4c4f69
            highlight TelescopePromptBorder   guibg=#e6e9ef guifg=#ccd0da
            highlight TelescopeResultsNormal  guibg=#eff1f5 guifg=#4c4f69
            highlight TelescopeResultsBorder  guibg=#eff1f5 guifg=#ccd0da
            highlight TelescopePreviewNormal  guibg=#f5f7fa guifg=#4c4f69
            highlight TelescopePreviewBorder  guibg=#f5f7fa guifg=#ccd0da
            highlight TelescopeSelection      guibg=#e6e9ef
            highlight TelescopeMatching       guifg=#7287fd gui=bold
          ]]

          -- Set borders for floating windowslocal orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
          vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#eff1f5 guifg=#4c4f69]]
          vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guibg=#eff1f5 guifg=#ccd0da]]
        end
      end
      -- Set the transparency of floating windows
      vim.o.winblend = 10

      require('notify').setup {
        background_colour = '#000000',
        merge_duplicates = true,
      }
    end,
  }
}
