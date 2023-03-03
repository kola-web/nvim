local status_ok, peek = pcall(require, 'peek')
if not status_ok then
  return
end

-- default config:
peek.setup {}
-- vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
-- vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

vim.api.nvim_create_user_command('PeekOpen', function()
  if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == 'markdown' then
    vim.fn.system 'yabai -m space --layout bsp'
    peek.open()
    vim.fn.system 'sleep 0.5 ; yabai -m space --rotate 180 ; yabai -m window --focus recent'
  end
end, {})

vim.api.nvim_create_user_command('PeekClose', function()
  if peek.is_open() then
    peek.close()
    vim.fn.system 'yabai -m space --layout stack'
  end
end, {})
