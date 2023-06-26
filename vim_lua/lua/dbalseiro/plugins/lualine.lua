local M = {}

function M.setup()
  local devicons_status, devicons = pcall(require, 'nvim-web-devicons')
  local lualine_status, lualine = pcall(require, 'lualine')

  if not devicons_status or not lualine_status then
    return
  end

  devicons.setup {
    default = true
  }

  lualine.setup {
    options = {
      section_separators = '',
      component_separators = '',
      theme = 'github_light'
    },
    sections = {
      lualine_c = {'%F'}
    },
    tabline = {
      lualine_a = {'buffers'},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
  }
end

return M
