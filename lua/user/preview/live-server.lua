local M = {
  'brianhuster/live-preview.nvim',
  dependencies = {
    -- 'brianhuster/autosave.nvim', -- Not required, but recomended for autosaving and sync scrolling
  },
  opts = {
    autokill = true,
    picker = 'fzf-lua',
  },
  keys = {
    { '<leader>ph', '<cmd>LivePreview start<cr>', desc = 'Open buffer in live preview' },
  },
}

return M
