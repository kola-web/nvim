local M = {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
}

M.config = function()
  require('neogen').setup({ snippet_engine = 'luasnip' })
end

return M
