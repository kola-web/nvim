local M = {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  config = true,
  keys = {
    -- t = { '<cmd>TodoTrouble<cr>', 'Todo' },
    -- T = { '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', 'Todo/FIX/FIXME' },
    {
      '<leader>xt',
      '<cmd>TodoTrouble<cr>',
      desc = 'Todo',
    },
    {
      '<leader>xT',
      '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>',
      desc = 'Todo/FIX/FIXME',
    },
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
  },
}

-- M.config = function(_, opts)
--   require('noice').setup(opts)
-- end

return M
