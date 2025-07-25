local M = {
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
    opts = {
      auto_close = true,
      focus = true,
      modes = {
        symbols = {
          win = {
            position = 'bottom',
          },
        },
      },
    },
  },
}

return M
