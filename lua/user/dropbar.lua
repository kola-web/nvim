local M = {
  'Bekaboo/dropbar.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '<C-;>',
      function()
        require('dropbar.api').pick()
      end,
      desc = 'color convert',
    },
  },
  config = function()
    vim.cmd([[highlight Winbar gui=none]])
  end,
}

return M
