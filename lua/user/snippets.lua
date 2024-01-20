local M = {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim', -- optional
  opts = {
    snippetDir = vim.fn.stdpath('config') .. '/snippets',
  },
}

return M
