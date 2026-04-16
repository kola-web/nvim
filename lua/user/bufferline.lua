local M = {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mini.nvim',
    },
    init = function()
      vim.o.showtabline = 2
      vim.o.tabline = ' '
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      tabpages = true,
      clickable = false,
      sidebar_filetypes = {},
      auto_hide = 0,
      icons = {
        separator = { left = '│', right = '│' },
        separator_at_end = false,
      },
      minimum_padding = 0,
      exclude_ft = { 'qf', '' },
      exclude_name = { '' },
    },
    keys = {
      { '<S-tab>', '<cmd>BufferPrevious<cr>', desc = 'Prev buffer' },
      { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
      { '(', '<cmd>BufferMovePrevious<cr>', desc = 'move prev' },
      { ')', '<cmd>BufferMoveNext<cr>', desc = 'move move' },
      { '<leader>br', '<cmd>BufferRestore<cr>', desc = 'Restore buffer' },
      { '<leader>bp', '<Cmd>BufferPin<CR>', desc = 'Toggle Pin' },
    },
  },
}

return M
