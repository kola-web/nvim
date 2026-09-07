vim.pack.add({
  'https://github.com/chrisgrieser/nvim-scissors',
})

local scissors = require('scissors')
scissors.setup({
  snippetDir = vim.fn.stdpath('config') .. '/snippets',
  editSnippetPopup = {
    keymaps = {
      deleteSnippet = '<leader>ld',
      duplicateSnippet = '<leader>lw',
    },
  },
})

vim.keymap.set('n', '<leader>v;', function()
  scissors.addNewSnippet()
end, { desc = 'snippet add' })
vim.keymap.set('n', '<leader>v:', function()
  scissors.editSnippet()
end, { desc = 'snippet edit' })
