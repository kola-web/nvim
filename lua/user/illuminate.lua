local M = {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}

return M
