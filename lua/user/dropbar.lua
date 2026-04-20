vim.pack.add({
  'https://github.com/Bekaboo/dropbar.nvim',
})

require('dropbar').setup({
  icons = {
    kinds = {
      symbols = require('mini.icons'),
    },
  },
})

vim.keymap.set('n', '<leader>;', function()
  local dropbar_api = require('dropbar.api')
  dropbar_api.pick()
end, { desc = 'Pick symbols in winbar' })
