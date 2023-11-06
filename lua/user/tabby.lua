local M = {
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    'famiu/bufdelete.nvim',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
  },
  version = '^1.0.0',
  event = { 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
  keys = {
    { '<S-tab>', '<cmd>BufferPrevious<cr>', desc = 'Prev buffer' },
    { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
    { '(', '<cmd>BufferMovePrevious<cr>', desc = 'move prev' },
    { ')', '<cmd>BufferMoveNext<cr>', desc = 'move move' },
  },
}

return M
