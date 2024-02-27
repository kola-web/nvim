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
        -- ai il
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
}

return M
