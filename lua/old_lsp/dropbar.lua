local M = {
  'Bekaboo/dropbar.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  keys = {
    {
      '<C-;>',
      function()
        require('dropbar.api').pick()
      end,
      desc = 'color convert',
    },
  },
}

return M
