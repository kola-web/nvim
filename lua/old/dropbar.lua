local M = {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  keys = {

    {
      { 'i', 'n' },
      '<C-;>',
      function()
        require('dropbar.api').pick()
      end,
      { silent = true, noremap = true },
    },
  },
}

return M
