local M = {
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
    dependencies = {
      {
        'kola-web/vim-indent-object',
      },
      {
        -- ae ie
        'kana/vim-textobj-entire',
      },
      {
        -- ax ix
        'whatyouhide/vim-textobj-xmlattr',
      },
      {
        -- ai il
        'kana/vim-textobj-line',
      },
    },
  },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
}

return M
