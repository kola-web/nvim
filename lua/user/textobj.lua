local M = {
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
    vscode = true,
    dependencies = {
      -- {
      --   'kola-web/vim-indent-object',
      --   cond = not vim.g.vscode,
      -- },
      {
        -- ae ie
        'kana/vim-textobj-entire',
        vscode = true,
      },
      {
        -- ax ix
        'whatyouhide/vim-textobj-xmlattr',
        vscode = true,
      },
      {
        -- al il
        'kana/vim-textobj-line',
        vscode = true,
      },
    },
  },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
    vscode = true,
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
