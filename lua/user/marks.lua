local M = {
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      local present, marks = pcall(require, "marks")
      if not present then
        return
      end
      marks.setup({})
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      local status_ok, todo = pcall(require, 'todo-comments')
      if not status_ok then
        return
      end

      todo.setup {}
    end
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
      local status_ok, trouble = pcall(require, "trouble")
      if not status_ok then
        return
      end

      trouble.setup {}
    end
  }
}


return M
