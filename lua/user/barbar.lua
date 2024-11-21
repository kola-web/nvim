local M = {
  {
    'romgrk/barbar.nvim',
    event = { 'VimEnter', 'InsertEnter', 'BufReadPre', 'BufAdd', 'BufNew', 'BufReadPost' },
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require('util.icons').diagnostics.Error },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = require('util.icons').diagnostics.Warn },
          [vim.diagnostic.severity.INFO] = { enabled = false, icon = require('util.icons').diagnostics.Info },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = require('util.icons').diagnostics.Hint },
        },
      },
      sidebar_filetypes = {
        undotree = {
          text = 'undotree',
          align = 'center',
        },
        ['neo-tree'] = {
          text = 'neo-tree',
          align = 'center',
        },
      },
      insert_at_end = false,
    },
    keys = {
      { '<S-tab>', '<cmd>BufferPrevious<cr>', desc = 'Prev buffer' },
      { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
      { '(', '<cmd>BufferMovePrevious<cr>', desc = 'move prev' },
      { ')', '<cmd>BufferMoveNext<cr>', desc = 'move move' },
      { '<leader>br', '<cmd>BufferRestore<cr>', desc = 'Restore buffer' },
      -- { '<leader>bo', '<cmd>BufferCloseAllButCurrent<cr>', desc = 'buffer Close All But Current' },
      -- { '<leader>c', '<cmd>BufferClose<cr>', desc = 'close current buffer' },
    },
  },
}

return M
