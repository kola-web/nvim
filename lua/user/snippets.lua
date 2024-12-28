local M = {
  'chrisgrieser/nvim-scissors',
  opts = {
    snippetDir = vim.fn.stdpath('config') .. '/snippets',
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
