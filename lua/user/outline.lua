vim.pack.add({
  'https://github.com/hedyhli/outline.nvim',
})

require('outline').setup({
  outline_window = {
    position = 'left',
  },
})

vim.keymap.set('n', '<leader>so', '<cmd>Outline<cr>', { desc = 'LSP Symbols' })

-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = vim.api.nvim_create_augroup('outline_auto_close', { clear = true }),
--   callback = function()
--     local ok, outline = pcall(require, 'outline')
--     if not ok then
--       return
--     end
--     if vim.bo.filetype ~= 'Outline' and outline.is_open() then
--       outline.close()
--     end
--   end,
-- })
