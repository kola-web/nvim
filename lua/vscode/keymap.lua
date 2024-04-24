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
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better window navigation
keymap({ 'n', 'x' }, '<C-h>', function() vscode.call('workbench.action.navigateLeft') end, { silent = true })
keymap({ 'n', 'x' }, '<C-j>', function() vscode.call('workbench.action.navigateDown') end, { silent = true })
keymap({ 'n', 'x' }, '<C-k>', function() vscode.call('workbench.action.navigateUp') end, { silent = true })
keymap({ 'n', 'x' }, '<C-l>', function() vscode.call('workbench.action.navigateRight') end, { silent = true })


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

-- substitute
keymap('n', 's', "<cmd>lua require('substitute').operator()<cr>", opts)
keymap('n', 'ss', "<cmd>lua require('substitute').line()<cr>", opts)
keymap('n', 'S', "<cmd>lua require('substitute').eol()<cr>", opts)
keymap('x', 's', "<cmd>lua require('substitute').visual()<cr>", opts)
vim.keymap.set('n', 'sx', "<cmd>lua require('substitute.exchange').operator()<cr>", opts)
vim.keymap.set('n', 'sxx', "<cmd>lua require('substitute.exchange').line()<cr>", opts)
vim.keymap.set('x', 'X', "<cmd>lua require('substitute.exchange').visual()<cr>", opts)
vim.keymap.set('n', 'sxc', "<cmd>lua require('substitute.exchange').cancel()<cr>", opts)

--abolish.vim
keymap('n', 'ga', '<Plug>(abolish-coerce-word)')
keymap('v', 'ga', '<Plug>(abolish-coerce)')

keymap('x', 'g=', '<Plug>(EasyAlign)')
keymap('n', 'g=', '<Plug>(EasyAlign)')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })


return {}
