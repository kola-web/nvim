local M = {
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    opts = {},
    -- stylua: ignore start
    keys = {
      { "]x", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[x", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoLocList<cr>", desc = "TodoLocList" },
      { "<leader>xT", "<cmd>TodoLocList  keywords=TODO,FIX,FIXME<cr>", desc = "TodoLocList Todo/Fix/Fixme" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
    -- stylua: ignore end
  },
}

return M
