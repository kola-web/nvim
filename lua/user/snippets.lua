local scissors_ok, scissors = pcall(require, 'scissors')
if scissors_ok then
  scissors.setup({
    snippetDir = vim.fn.stdpath('config') .. '/snippets',
    editSnippetPopup = {
      keymaps = {
        deleteSnippet = '<leader>ld',
        duplicateSnippet = '<leader>lw',
      },
    },
  })
end

vim.keymap.set('n', '<leader>l;', function()
  if scissors_ok then
    scissors.addNewSnippet()
  end
end, { desc = 'snippet add' })
vim.keymap.set('n', '<leader>l:', function()
  if scissors_ok then
    scissors.editSnippet()
  end
end, { desc = 'snippet edit' })
