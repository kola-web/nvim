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
    }
  },
  event = "VeryLazy"
}

return M

-- local M = {
--   "kola-web/nvim-various-textobjs",
--   opts = { useDefaultKeymaps = true },
--   event = "VeryLazy",
-- }
--
-- return M
