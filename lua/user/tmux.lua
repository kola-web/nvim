local M = {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    build = 'bash ./kitty/install-kittens.bash',
    -- stylua: ignore
    keys = {
      -- add a keymap to browse plugin files
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "move cursor left", },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "move cursor down" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "move cursor up" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "move cursor right" },

      { "<C-left>", function() require("smart-splits").resize_left() end, desc = "resize left" },
      { "<C-down>", function() require("smart-splits").resize_down() end, desc = "resize down" },
      { "<C-up>", function() require("smart-splits").resize_up() end, desc = "resize up" },
      { "<C-right>", function() require("smart-splits").resize_right() end, desc = "resize right" },


      { "<leader>bh",function () require('smart-splits').swap_buf_left() end, desc = "swap buf left" },
      { "<leader>bh",function () require('smart-splits').swap_buf_down() end, desc = "swap buf down" },
      { "<leader>bk",function () require('smart-splits').swap_buf_up() end, desc = "swap buf up" },
      { "<leader>bl",function () require('smart-splits').swap_buf_right() end, desc = "swap buf right" },
    },
  },
}

return M
