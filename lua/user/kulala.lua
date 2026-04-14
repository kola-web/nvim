local kulala_ok, kulala = pcall(require, 'kulala')
if kulala_ok then
  kulala.setup({
    global_keymaps = false,
    global_keymaps_prefix = '<leader>k',
    kulala_keymaps_prefix = '',
  })
end

vim.keymap.set('n', '<leader>ks', function() end, { desc = 'Send request' })
vim.keymap.set('n', '<leader>ka', function() end, { desc = 'Send all requests' })
vim.keymap.set('n', '<leader>kb', function() end, { desc = 'Open scratchpad' })
