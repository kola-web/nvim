local M = {
  'protex/better-digraphs.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',
}

M.config = function()
  local keymap = vim.keymap.set
  -- Silent keymap option
  local opts = { silent = true, noremap = true }
  keymap('i', '<C-x><C-x>', "<Cmd>lua require'better-digraphs'.digraphs('insert')<CR>", opts)
end

return M
