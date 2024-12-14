local M = {
  'xiyaowong/fast-cursor-move.nvim',
  enabled = vim.g.vscode,
  config = function()
    vim.g.fast_cursor_move_acceleration = false
  end,
}

return M
