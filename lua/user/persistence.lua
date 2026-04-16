vim.pack.add({
  'https://github.com/folke/persistence.nvim',
})

local persistence = require('persistence')
persistence.setup({})

vim.keymap.set('n', '<leader>pr', function()
  persistence.load()
end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>pl', function()
  persistence.select()
end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>pL', function()
  persistence.load({ last = true })
end, { desc = 'load the last session' })
vim.keymap.set('n', '<leader>pd', function()
  persistence.stop()
end, { desc = "session won't be saved on exit" })
