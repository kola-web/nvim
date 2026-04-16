vim.pack.add({
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/mhinz/vim-signify',
  'https://github.com/NeogitOrg/neogit',
})
require('codediff').setup()
vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff' })
vim.keymap.set('n', '<leader>gh', '<cmd>CodeDiff history %<cr>', { desc = 'CodeDiff History %' })
vim.keymap.set('n', '<leader>gH', '<cmd>CodeDiff history<cr>', { desc = 'CodeDiff History' })

vim.g.signify_skip = { vcs = { allow = { 'git', 'svn' } } }
vim.g.signify_priority = 5
vim.g.signify_sign_show_count = 0
vim.g.signify_sign_add = '▎'
vim.g.signify_sign_change = '▎'
vim.g.signify_sign_change_delete = '▎'
vim.g.signify_sign_delete = ''
vim.g.signify_sign_delete_first_line = ''
vim.g.signify_number_highlight = 0

local is_win = require('utils.init').is_win()
if is_win then
  vim.g.signify_difftool = 'C:\\Program Files\\Git\\usr\\bin\\diff.exe'
end

vim.keymap.set('n', '<leader>gD', '<cmd>SignifyDiff<cr>', { desc = 'SignifyDiff' })
vim.keymap.set('n', '<leader>gi', '<cmd>SignifyHunkDiff<cr>', { desc = 'SignifyHunkDiff' })
vim.keymap.set('n', '<leader>gu', '<cmd>SignifyHunkUndo<cr>', { desc = 'SignifyHunkUndo' })
vim.keymap.set('n', '[h', '<plug>(signify-prev-hunk)', { desc = 'prev hunk' })
vim.keymap.set('n', ']h', '<plug>(signify-next-hunk)', { desc = 'next hunk' })

local neogit_ok, neogit = pcall(require, 'neogit')
if neogit_ok then
  neogit.setup({})
end

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Neogit' })
