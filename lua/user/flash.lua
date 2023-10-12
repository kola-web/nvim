local M = {
  'folke/flash.nvim',
  opts = {
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = false,
      },
      treesitter = {
        label = { before = false, after = false, style = 'overlay' },
      },
    },
  },
}

return M
