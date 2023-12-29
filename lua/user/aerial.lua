local M = {
  'stevearc/aerial.nvim',
  event = 'LspAttach',
  opts = {
    layout = {
      min_width = '20',
      default_direction = 'prefer_left',
    },
  },
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

return M
