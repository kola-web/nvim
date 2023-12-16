local M = {
  -- {
  --   'aserowy/tmux.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     local status_ok, tmux = pcall(require, 'tmux')
  --     if not status_ok then
  --       return
  --     end
  --
  --     tmux.setup({
  --       copy_sync = {
  --         enable = false,
  --       },
  --       navigation = {
  --         enable_default_keybindings = true,
  --       },
  --       resize = {
  --         enable_default_keybindings = false,
  --       },
  --     })
  --   end,
  -- },

  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    config = function()
      print(vim.env.KITTY_LISTEN_ON)
      require('smart-splits').setup({
        multiplexer_integration = vim.env.KITTY_LISTEN_ON ~= nil and 'kitty' or nil,
      })
      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

      vim.keymap.set('n', '<C-left>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<C-down>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<C-up>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<C-right>', require('smart-splits').resize_right)
    end,
  },
}

return M
