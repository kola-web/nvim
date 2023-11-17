local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    jump = {
      nohlsearch = true,
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = false,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
  },
}

return M
