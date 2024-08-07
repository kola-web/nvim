local M = {
  'mbbill/undotree',
  keys = {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = 'undotree',
      { mode = 'n' },
    },
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}

return M
