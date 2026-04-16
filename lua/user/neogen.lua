vim.pack.add({
  'https://github.com/danymat/neogen',
})

local neogen = require('neogen')
neogen.setup({})

vim.keymap.set('n', '<leader>ll', '<cmd>lua require("neogen").generate()<CR>', { desc = 'jsDoc' })
