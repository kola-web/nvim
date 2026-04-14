local neogen_ok, neogen = pcall(require, 'neogen')
if neogen_ok then
  neogen.setup({})
end

vim.keymap.set('n', '<leader>ll', '<cmd>lua require("neogen").generate()<CR>', { desc = 'jsDoc' })
