local M = {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {},
  keys = {
    {
      '<leader>ll',
      '<cmd>lua require("neogen").generate()<CR>',
      desc = 'jsDoc',
    },
  },
}

return M
