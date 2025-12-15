local M = {
  -- {
  --   'echasnovski/mini.tabline',
  --   version = '*',
  --   opts = {
  --     format = function(buf_id, label)
  --       local suffix = ''
  --       if vim.bo[buf_id].modified then
  --         suffix = '● '
  --       elseif vim.bo[buf_id].readonly then
  --         suffix = ' '
  --       end
  --       return MiniTabline.default_format(buf_id, label) .. suffix
  --     end,
  --   },
  -- },

  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
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
      icons = {
        separator = { left = '│', right = '│' },
        separator_at_end = false,
      },
      minimum_padding = 0,
      exclude_ft = { 'qf' },
      exclude_name = {},
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
