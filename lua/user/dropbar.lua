local M = {
  {
    'Bekaboo/dropbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mini.nvim',
    },
    opts = function()
      return {
        icons = {
          kinds = {
            symbols = require('mini.icons'),
          },
        },
      }
    end,
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
