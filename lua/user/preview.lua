vim.pack.add({
  'https://github.com/brianhuster/live-preview.nvim',
})
local live_preview = require('livepreview')
require('livepreview.config').set()

vim.keymap.set('n', '<leader>qh', '<cmd>LivePreview start<cr>', { desc = 'Open buffer in live preview' })
