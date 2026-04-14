local colorizer_ok, colorizer = pcall(require, 'colorizer')
if colorizer_ok then
  colorizer.setup({
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      RRGGBBAA = true,
      css = true,
      names = false,
    },
  })
end

local color_converter_ok, color_converter = pcall(require, 'color-converter')
if color_converter_ok then
  color_converter.setup({
    rgb_pattern = 'rgba([r],[g],[b], 1)',
  })
end

vim.keymap.set('n', '<leader>rh', function()
  if color_converter_ok then
    require('color-converter').to_hex()
  end
end, { desc = 'rgba to hex', silent = true })
vim.keymap.set('n', '<leader>rg', function()
  if color_converter_ok then
    require('color-converter').to_rgb()
  end
end, { desc = 'hex to rgba', silent = true })
