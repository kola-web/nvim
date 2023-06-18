local M = {
  "protex/better-digraphs.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy",
}

M.config = function()
  local keymap = vim.keymap.set
  -- Silent keymap option
  local opts = { silent = true, noremap = true }
  keymap("i", "<C-l><C-k>", "<Cmd>lua require'better-digraphs'.digraphs('insert')<CR>", opts)
  keymap("n", "r<C-l><C-k>", "<Cmd>lua require'better-digraphs'.digraphs('normal')<CR>", opts)
  keymap("v", "r<C-l><C-k>", "<ESC><Cmd>lua require'better-digraphs'.digraphs('visual')<CR>", opts)
end

return M

