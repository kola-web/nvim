local M = {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = true,
    opts = { style = 'moon', transparent = false },
  },
  {
    priority = 1000,
    lazy = false,
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}

return M
