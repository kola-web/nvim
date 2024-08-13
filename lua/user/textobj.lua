local M = {
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
    dependencies = {
      {
        -- ae ie
        'kana/vim-textobj-entire',
      },
      {
        -- ax ix
        'whatyouhide/vim-textobj-xmlattr',
      },
      {
        -- al il
        'kana/vim-textobj-line',
      },
      {
        -- ac ic
        'glts/vim-textobj-comment',
      },
    },
  },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },
}

return M
