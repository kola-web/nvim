local persistence_ok, persistence = pcall(require, 'persistence')
if persistence_ok then
  persistence.setup({})
end

vim.keymap.set('n', '<leader>pr', function()
  if persistence_ok then
    persistence.load()
  end
end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>pl', function()
  if persistence_ok then
    persistence.select()
  end
end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>pL', function()
  if persistence_ok then
    persistence.load({ last = true })
  end
end, { desc = 'load the last session' })
vim.keymap.set('n', '<leader>pd', function()
  if persistence_ok then
    persistence.stop()
  end
end, { desc = "session won't be saved on exit" })
