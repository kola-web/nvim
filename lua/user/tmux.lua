local has = vim.fn.has
local is_win = has('win32')
local M = {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    build = is_win and '' or 'bash ./kitty/install-kittens.bash',
    opts = {},
    init = function()
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      vim.keymap.set('n', '<C-Left>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<C-Down>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<C-Up>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<C-Right>', require('smart-splits').resize_right)
      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
      vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
    end,
  },
}

return M
