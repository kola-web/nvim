local M = {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      sidebar_filetypes = {
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
      { '<leader>bp', '<Cmd>BufferPin<CR>', desc = 'Toggle Pin' },
    },
  },

  -- {
  --   'echasnovski/mini.tabline',
  --   version = '*',
  --   opts = {
  --     format = function(buf_id, label)
  --       local suffix = vim.bo[buf_id].modified and '* ' or ''
  --       return MiniTabline.default_format(buf_id, label) .. suffix
  --     end,
  --   },
  -- },
}

return M
