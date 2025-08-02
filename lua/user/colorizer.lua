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
    opts = {
      rgb_pattern = 'rgba([r],[g],[b], 1)',
    },
    keys = {
      {
        '<leader>rh',
        function()
          require('color-converter').to_hex()
        end,
        desc = 'rgba to hex',
        silent = true,
      },
      {
        '<leader>rg',
        function()
          require('color-converter').to_rgb()
        end,
        desc = 'hex to rgba',
        silent = true,
      },
    },
  },
}

return M
