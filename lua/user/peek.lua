-- init.lua
vim.pack.add({
  'https://github.com/toppair/peek.nvim',
})
local peek = require('peek')

peek.setup({
  syntax = false,
  app = 'browser',
})

vim.api.nvim_create_user_command('PeekOpen', function()
  local buf = vim.api.nvim_get_current_buf()
  if not peek.is_open() and vim.bo[buf].filetype == 'markdown' then
    if vim.fn.has('macunix') == 1 then
      vim.fn.system('yabai -m space --layout bsp')
      peek.open()
      vim.fn.system('sleep 0.5 ; yabai -m space --rotate 180 ; yabai -m window --focus recent')
    else
      peek.open()
    end
  end
end, {})

vim.api.nvim_create_user_command('PeekClose', function()
  if peek.is_open() then
    if vim.fn.has('macunix') == 1 then
      peek.close()
      vim.fn.system('yabai -m space --layout stack')
    else
      peek.close()
    end
  end
end, {})
