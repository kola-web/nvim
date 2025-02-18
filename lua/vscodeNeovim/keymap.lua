if not vim.g.vscode then
  return {}
end
-- Shorten function name
local vscode = require('vscode-neovim')
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap('i', '<C-e>', '<End>', opts)
keymap('i', '<C-a>', '<Home>', opts)

-- better up/down
-- keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- keymap({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- keymap({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


-- Better window navigation
-- stylua: ignore start
keymap({ 'n', 'x' }, '<C-h>', function() vscode.call('workbench.action.navigateLeft') end, { silent = true })
keymap({ 'n', 'x' }, '<C-j>', function() vscode.call('workbench.action.navigateDown') end, { silent = true })
keymap({ 'n', 'x' }, '<C-k>', function() vscode.call('workbench.action.navigateUp') end, { silent = true })
keymap({ 'n', 'x' }, '<C-l>', function() vscode.call('workbench.action.navigateRight') end, { silent = true })
-- stylua: ignore end

-- All
keymap('', '<S-l>', '$', opts)
keymap('', '<S-h>', '^', opts)

-- keymap('n', '<C-m>', '%', opts)
-- keymap("n", "<C-z>", "<nop>", opts)

-- vue jump
keymap('n', ']t', '/<template<cr>', opts)
keymap('n', ']s', '/<script<cr>', opts)
keymap('n', ']c', '/<style<cr>', opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap('n', '<tab>', '<Cmd>BufferLineCycleNext<CR>', opts)
-- keymap('n', '<S-tab>', '<Cmd>BufferLineCyclePrev<CR>', opts)
keymap('n', '<tab>', '<Cmd>bnext<CR>', opts)
keymap('n', '<S-tab>', '<Cmd>bprevious<CR>', opts)

-- smart n/N
keymap('n', 'n', vim.v.searchforward == 1 and 'n' or 'N', opts)
keymap('n', 'N', vim.v.searchforward == 1 and 'N' or 'n', opts)

-- add space line
keymap('n', ']<space>', "<Cmd>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>", opts)
keymap('n', '[<space>', "<Cmd>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>", opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

--abolish.vim
keymap('n', 'ga', '<Plug>(abolish-coerce-word)')
keymap('v', 'ga', '<Plug>(abolish-coerce)')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- stylua: ignore start
keymap('', '<space>', function() vscode.call('whichkey.show') end, { silent = true })
keymap('n', '(', function() vscode.call('workbench.action.moveEditorLeftInGroup') end, opts)
keymap('n', ')', function() vscode.call('workbench.action.moveEditorRightInGroup') end, opts)


keymap('n', '<leader>rc', require('utils.compile_scss'), { desc = 'toggle scss compile' })
keymap('n', '<leader>rd', '<cmd>%s/<div/<view/g<cr><cmd>%s/<\\/div/<\\/view/g<cr>', { desc = 'div -> view' })
keymap('n', '<leader>rv', '<cmd>%s/<view/<div/g<cr><cmd>%s/<\\/view/<\\/div/g<cr>', { desc = 'view -> div' })
keymap('n', '<leader>rp', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%d",submatch(1))."rpx"#g<cr>', { desc = 'px -> rpx' })
keymap('n', '<leader>rP', '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1))."px"#g<cr>', { desc = 'rpx -> px' })
keymap('n', '<leader>ro', '<cmd>%s#\\(\\d\\+\\)rpx#\\=printf("%d",submatch(1) / 2)."px"#g<cr>', { desc = 'rpx/2 -> px' })
keymap('n', '<leader>re', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%f",submatch(1) / 100.0)."rem"#g<cr>',
  { desc = 'px -> rem' })
keymap('n', '<leader>rl', '<cmd>%s#\\(\\d\\+\\)px#\\=printf("%.2f",submatch(1) / 1080.0 * 750)."px"#g<cr>',
  { desc = '1080px -> 750px' })
keymap('n', '<leader>rr', require('utils.quickType').generate_type, { desc = 'quicktype' })

keymap('x', 'zV', function() vscode.call('editor.foldAllExcept') end, opts)

keymap('n', 'za', function() vscode.call('editor.toggleFold') end, opts)
keymap('n', 'zR', function() vscode.call('editor.unfoldAll') end, opts)
keymap('n', 'zM', function() vscode.call('editor.foldAll') end, opts)
keymap('n', 'zo', function() vscode.call('editor.unfold') end, opts)
keymap('n', 'zO', function() vscode.call('editor.unfoldRecursively') end, opts)
keymap('n', 'zc', function() vscode.call('editor.fold') end, opts)
keymap('n', 'zC', function() vscode.call('editor.foldRecursively') end, opts)

keymap('n', 'z1', function() vscode.call('editor.foldLevel1') end, opts)
keymap('n', 'z2', function() vscode.call('editor.foldLevel2') end, opts)
keymap('n', 'z3', function() vscode.call('editor.foldLevel3') end, opts)
keymap('n', 'z4', function() vscode.call('editor.foldLevel4') end, opts)
keymap('n', 'z5', function() vscode.call('editor.foldLevel5') end, opts)
keymap('n', 'z6', function() vscode.call('editor.foldLevel6') end, opts)
keymap('n', 'z7', function() vscode.call('editor.foldLevel7') end, opts)

vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = false, silent = true })

-- stylua: ignore end

return {}
