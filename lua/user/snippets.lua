local M = {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim', -- optional
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
