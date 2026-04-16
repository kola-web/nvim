vim.pack.add({
  'https://github.com/romgrk/barbar.nvim',
})

vim.o.showtabline = 2
vim.o.tabline = ' '
vim.g.barbar_auto_setup = false

require('barbar').setup({
  animation = false,
  tabpages = true,
  clickable = false,
  sidebar_filetypes = {},
  -- auto_hide = true,
  icons = {
    separator = { left = '│', right = '│' },
    separator_at_end = false,

    -- filetype = {
    --   custom_colors = false,
    --   enabled = false,
    -- },
  },
  minimum_padding = 0,
  exclude_ft = { 'qf', '' },
  exclude_name = { '[buffer %d+]' },
})

vim.keymap.set('n', '<S-tab>', '<cmd>BufferPrevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<tab>', '<cmd>BufferNext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '(', '<cmd>BufferMovePrevious<cr>', { desc = 'move prev' })
vim.keymap.set('n', ')', '<cmd>BufferMoveNext<cr>', { desc = 'move move' })
vim.keymap.set('n', '<leader>br', '<cmd>BufferRestore<cr>', { desc = 'Restore buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Toggle Pin' })
