vim.pack.add({
  'https://github.com/MagicDuck/grug-far.nvim',
})

local grug_far = require('grug-far')
grug_far.setup({
  headerMaxWidth = 80,
  engines = {
    ripgrep = {
      extraArgs = '-P',
    },
  },
  keymaps = {
    close = { n = 'q' },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>rs', function()
  grug_far.open({
    transient = true,
    prefills = {},
  })
end, { desc = 'Search and Replace' })
vim.keymap.set('n', '<leader>ri', function()
  grug_far.open({
    transient = true,
    prefills = {
      search = '([\'"])(/images/)(.*?)(\\1)',
      replacement = '$1{{imageUrl}}$3?t={{Timestamp}}$4',
      filesFilter = '*.wxml',
      flags = '-g !src/custom-tab-bar',
    },
  })
end, { desc = 'Replace images' })
