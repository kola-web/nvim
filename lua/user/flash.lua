local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    jump = {
      nohlsearch = true,
    },
    modes = {
      char = {
        autohide = true,
        jump_labels = true,
        highlight = {
          backdrop = false,
        },
      },
    },
  },
}

return M
