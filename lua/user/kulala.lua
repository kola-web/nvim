vim.pack.add({
  'https://github.com/mistweaverco/kulala.nvim',
})

local kulala = require('kulala')
kulala.setup({
  global_keymaps = false,
  global_keymaps_prefix = '<leader>k',
  kulala_keymaps_prefix = '',
})
