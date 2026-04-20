vim.pack.add({
  'https://github.com/stevearc/aerial.nvim',
})

require('aerial').setup({
  layout = {
    default_direction = 'prefer_left',
  },
})

vim.keymap.set('n', '<leader>so', '<cmd>AerialToggle<cr>', { desc = 'LSP Symbols' })
