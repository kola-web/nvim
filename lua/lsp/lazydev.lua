local M = {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'lazy.nvim',
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'mini.statusline', words = { 'MiniStatusline' } },
      },
    },
  },
}

return M
