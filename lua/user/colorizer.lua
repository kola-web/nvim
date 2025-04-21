local M = {
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        css = true,
        names = false, -- "Name" codes like Blue or blue
      },
    },
  },
  {
    'NTBBloodbath/color-converter.nvim',
    opts = {},
    keys = {
      {
        '<A-->',
        '<Plug>ColorConvertCycle',
        desc = 'ColorConvertCycle',
        silent = true,
      },
    },
  },
}

return M
