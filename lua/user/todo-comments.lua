local todo_comments_ok, todo_comments = pcall(require, 'todo-comments')
if todo_comments_ok then
  todo_comments.setup({})
end

vim.keymap.set('n', ']x', function()
  if todo_comments_ok then
    require("todo-comments").jump_next()
  end
end, { desc = "Next Todo Comment" })
vim.keymap.set('n', '[x', function()
  if todo_comments_ok then
    require("todo-comments").jump_prev()
  end
end, { desc = "Previous Todo Comment" })
vim.keymap.set('n', '<leader>xt', '<cmd>TodoLocList<cr>', { desc = "TodoLocList" })
vim.keymap.set('n', '<leader>xT', '<cmd>TodoLocList  keywords=TODO,FIX,FIXME<cr>', { desc = "TodoLocList Todo/Fix/Fixme" })
vim.keymap.set('n', '<leader>st', function()
  Snacks.picker.todo_comments()
end, { desc = "Todo" })
vim.keymap.set('n', '<leader>sT', function()
  Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todo/Fix/Fixme" })
