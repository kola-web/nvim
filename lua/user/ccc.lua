local M = {
  'uga-rosa/ccc.nvim',
  event = 'BufRead',
  opts = {
    highlighter = {
      auto_enable = false,
      lsp = false,
    },
  },
  keys = {
    { '<C-->', '<cmd>CccConvert<cr>', desc = 'color convert' },
    { '<C-_>', '<cmd>CccPick<cr>', desc = 'color pick' },
  },
  config = function(_, opts)
    require('ccc').setup(opts)
  end,
}

return M
