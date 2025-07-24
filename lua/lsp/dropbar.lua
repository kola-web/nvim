local M = {
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    opts = {
      icons = {
        kinds = {
          symbols = require('mini.icons'),
        },
      },
    },
    keys = {
      {
        '<leader>;',
        function()
          local dropbar_api = require('dropbar.api')
          dropbar_api.pick()
        end,
        { desc = 'Pick symbols in winbar' },
      },
    },
  },
}

return M
