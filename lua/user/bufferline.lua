vim.pack.add({
  'https://github.com/romgrk/barbar.nvim',
})

vim.o.showtabline = 2
vim.g.barbar_auto_setup = false

require('barbar').setup({
  animation = false,
  tabpages = true,
  clickable = false,
  sidebar_filetypes = {},
  auto_hide = false,
  minimum_padding = 0,
  maximum_padding = 1,
  maximum_length = 20, -- buffer名字最大长度，避免占满屏幕
  no_name_title = ' ',
  exclude_ft = {
    'qf',
    'git',
    'trouble',
    'toggleterm',
    'NvimTree',
    'help',
    'man',
  },
})

vim.keymap.set('n', '<S-tab>', '<cmd>BufferPrevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<tab>', '<cmd>BufferNext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '(', '<cmd>BufferMovePrevious<cr>', { desc = 'move prev' })
vim.keymap.set('n', ')', '<cmd>BufferMoveNext<cr>', { desc = 'move move' })
vim.keymap.set('n', '<leader>br', '<cmd>BufferRestore<cr>', { desc = 'Restore buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Toggle Pin' })
