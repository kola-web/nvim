local M = {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function(_, opts)
  vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
  end, { desc = 'Next todo comment' })

  vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
  end, { desc = 'Previous todo comment' })

  require('noice').setup(opts)
end

return M
