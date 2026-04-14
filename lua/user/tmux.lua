local has = vim.fn.has
local is_win = has('win32')

local smart_splits_ok, smart_splits = pcall(require, 'smart-splits')
if smart_splits_ok then
  smart_splits.setup({})
end

vim.keymap.set('n', '<C-Left>', function()
  if smart_splits_ok then
    require('smart-splits').resize_left()
  end
end, {})
vim.keymap.set('n', '<C-Down>', function()
  if smart_splits_ok then
    require('smart-splits').resize_down()
  end
end, {})
vim.keymap.set('n', '<C-Up>', function()
  if smart_splits_ok then
    require('smart-splits').resize_up()
  end
end, {})
vim.keymap.set('n', '<C-Right>', function()
  if smart_splits_ok then
    require('smart-splits').resize_right()
  end
end, {})
vim.keymap.set('n', '<C-h>', function()
  if smart_splits_ok then
    require('smart-splits').move_cursor_left()
  end
end, {})
vim.keymap.set('n', '<C-j>', function()
  if smart_splits_ok then
    require('smart-splits').move_cursor_down()
  end
end, {})
vim.keymap.set('n', '<C-k>', function()
  if smart_splits_ok then
    require('smart-splits').move_cursor_up()
  end
end, {})
vim.keymap.set('n', '<C-l>', function()
  if smart_splits_ok then
    require('smart-splits').move_cursor_right()
  end
end, {})
vim.keymap.set('n', '<C-\\>', function()
  if smart_splits_ok then
    require('smart-splits').move_cursor_previous()
  end
end, {})
