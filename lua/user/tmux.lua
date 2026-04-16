vim.pack.add({
  'https://github.com/mrjones2014/smart-splits.nvim',
})

local smart_splits = require('smart-splits')
smart_splits.setup({})

vim.keymap.set('n', '<C-Left>', function()
  require('smart-splits').resize_left()
end, {})
vim.keymap.set('n', '<C-Down>', function()
  require('smart-splits').resize_down()
end, {})
vim.keymap.set('n', '<C-Up>', function()
  require('smart-splits').resize_up()
end, {})
vim.keymap.set('n', '<C-Right>', function()
  require('smart-splits').resize_right()
end, {})
vim.keymap.set('n', '<C-h>', function()
  require('smart-splits').move_cursor_left()
end, {})
vim.keymap.set('n', '<C-j>', function()
  require('smart-splits').move_cursor_down()
end, {})
vim.keymap.set('n', '<C-k>', function()
  require('smart-splits').move_cursor_up()
end, {})
vim.keymap.set('n', '<C-l>', function()
  require('smart-splits').move_cursor_right()
end, {})

-- vim.keymap.set('n', '<C-\\>', function()
--   if smart_splits_ok then
--     require('smart-splits').move_cursor_previous()
--   end
-- end, {})
