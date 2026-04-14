local live_preview_ok, live_preview = pcall(require, 'livepreview')
if live_preview_ok then
  require('livepreview.config').set()
end

vim.keymap.set('n', '<leader>qh', '<cmd>LivePreview start<cr>', { desc = 'Open buffer in live preview' })
