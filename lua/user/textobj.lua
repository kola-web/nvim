local M = {
  'kana/vim-textobj-user',
  dependencies = {
    -- {
    --   'kola-web/vim-indent-object',
    -- },
    {
      'kana/vim-textobj-entire',
    },
    {
      'whatyouhide/vim-textobj-xmlattr',
    },
    {
      'wellle/targets.vim',
    },
  },
  event = 'VeryLazy',
}

return M
