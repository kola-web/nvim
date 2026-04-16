vim.pack.add({
  'https://github.com/tpope/vim-repeat',
  'https://github.com/chrisgrieser/nvim-various-textobjs',
})

local various_textobjs_ok, various_textobjs = pcall(require, 'various-textobjs')
if various_textobjs_ok then
  various_textobjs.setup({
    keymaps = {
      useDefaults = false,
    },
  })
end

vim.keymap.set({ 'x', 'o' }, 'ae', '<cmd>lua require("various-textobjs").entireBuffer()<CR>', {})
vim.keymap.set({ 'x', 'o' }, 'ic', '<cmd>lua require("various-textobjs").color("inner")<CR>', {})
vim.keymap.set({ 'x', 'o' }, 'ac', '<cmd>lua require("various-textobjs").color("outer")<CR>', {})
vim.keymap.set({ 'x', 'o' }, 'ii', '<cmd>lua require("various-textobjs").indentation("inner","inner")<CR>', {})
vim.keymap.set({ 'x', 'o' }, 'ai', '<cmd>lua require("various-textobjs").indentation("outer","outer")<CR>', {})
