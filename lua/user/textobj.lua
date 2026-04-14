vim.g.netrw_nogx = 1

local gx_ok, gx = pcall(require, 'gx')
if gx_ok then
  gx.setup({})
end

vim.keymap.set({ 'n', 'x' }, 'gx', '<cmd>Browse<cr>', {})

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
