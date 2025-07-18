local M = {
  {
    'MagicDuck/grug-far.nvim',
    event = 'VeryLazy',
    cmd = 'GrugFar',
    opts = {
      headerMaxWidth = 80,
      keymaps = {},
    },
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require('grug-far')
          local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },
}
return M
