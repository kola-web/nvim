local M = {
  'chrisgrieser/nvim-scissors',
  opts = {
    snippetDir = vim.fn.stdpath('config') .. '/snippets',
    editSnippetPopup = {
      keymaps = {
        deleteSnippet = '<leader>ld', -- same as `genghis` mapping for deleting file
        duplicateSnippet = '<leader>lw', -- same as `genghis` mapping for duplicating file
      },
    },
  },
  keys = {
    {
      '<leader>l;',
      function()
        require('scissors').addNewSnippet()
      end,
      desc = 'snippet add',
    },
    {
      '<leader>l:',
      function()
        require('scissors').editSnippet()
      end,
      desc = 'snippet edit',
    },
  },
}

return M
