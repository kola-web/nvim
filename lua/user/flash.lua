local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    jump = {
      nohlsearch = true,
    },
    modes = {
      search = {
        -- enabled = false,
      },
      char = {
        -- enabled = false,
        highlight = { backdrop = false },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
  },
}

return M
