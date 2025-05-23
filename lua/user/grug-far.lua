local M = {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    opts = {
      headerMaxWidth = 80,
      keymaps = {
        replace = { n = '<enter>' },
        gotoLocation = { n = '<C-]>' },
        pickHistoryEntry = { n = '<C-]>' },
      },
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
