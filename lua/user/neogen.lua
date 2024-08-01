local M = {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {
    snippet_engine = 'luasnip',
  },
  keys = {
    {
      '<leader>ll',
      '<cmd>lua require("neogen").generate()<CR>',
      desc = 'jsDoc',
    },
  },
}

return M
