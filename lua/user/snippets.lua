local M = {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim', -- optional
  opts = {
    snippetDir = vim.fn.stdpath('config') .. '/snippets',
  },
  keys = {
    {
      '<leader>na',
      function()
        require('scissors').addNewSnippet()
      end,
      'snippet add',
    },
    {
      '<leader>ne',
      function()
        require('scissors').editSnippet()
      end,
      'snippet edit',
    },
  },
}

return M
