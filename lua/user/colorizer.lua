vim.pack.add({
  'https://github.com/NvChad/nvim-colorizer.lua',
  'https://github.com/NTBBloodbath/color-converter.nvim',
})

local colorizer = require('colorizer')
colorizer.setup({
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    css = true,
    names = false,
  },
})

local color_converter = require('color-converter')
color_converter.setup({
  rgb_pattern = 'rgba([r],[g],[b], 1)',
})

vim.keymap.set('n', '<leader>rh', function()
  require('color-converter').to_hex()
end, { desc = 'rgba to hex', silent = true })
vim.keymap.set('n', '<leader>rg', function()
  require('color-converter').to_rgb()
end, { desc = 'hex to rgba', silent = true })
