local M = {
  "LunarVim/bigfile.nvim",
  event = { "FileReadPre", "BufReadPre", "User FileOpened" }
}

M.opts = {
  filesize = 1,
  pattern = { "*" }, -- autocmd pattern
  features = {       -- features to disable
    "indent_blankline",
    "illuminate",
    "lsp",
    "treesitter",
    "syntax",
    "matchparen",
    "vimopts",
    "filetype",
  },
}

return M
