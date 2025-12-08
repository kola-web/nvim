local M = {
  'brianhuster/live-preview.nvim',
  config = function()
    require('livepreview.config').set()
  end,
  keys = {
    { '<leader>qh', '<cmd>LivePreview start<cr>', desc = 'Open buffer in live preview' },
  },
}

return M
