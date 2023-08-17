local M = {
  "kana/vim-textobj-user",
  dependencies = {
    {
      "kola-web/vim-indent-object",
    },
    {
      "kana/vim-textobj-entire",
    },
    {
      "whatyouhide/vim-textobj-xmlattr",
    },
    {
      "glts/vim-textobj-comment",
    },
    {
      "wellle/targets.vim",
    },
    {
      "junegunn/vim-easy-align"
    }
  },
  event = "VeryLazy"
}

return M
