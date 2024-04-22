-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap('i', '<C-e>', '<End>', opts)
keymap('i', '<C-a>', '<Home>', opts)

-- Allow clipboard copy paste in neovim
keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- better up/down
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
keymap('n', '<D-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
keymap('n', '<D-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
keymap('i', '<D-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
keymap('i', '<D-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
keymap('v', '<D-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
keymap('v', '<D-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- fold
keymap('n', 'z1', '<cmd>set foldlevel=1<cr>', { desc = 'Fold level 1' })
keymap('n', 'z2', '<cmd>set foldlevel=2<cr>', { desc = 'Fold level 2' })
keymap('n', 'z3', '<cmd>set foldlevel=3<cr>', { desc = 'Fold level 3' })
keymap('n', 'z4', '<cmd>set foldlevel=4<cr>', { desc = 'Fold level 4' })
keymap('n', 'z5', '<cmd>set foldlevel=5<cr>', { desc = 'Fold level 5' })
keymap('n', 'z6', '<cmd>set foldlevel=6<cr>', { desc = 'Fold level 6' })
keymap('n', 'z7', '<cmd>set foldlevel=7<cr>', { desc = 'Fold level 7' })
keymap('n', 'z8', '<cmd>set foldlevel=8<cr>', { desc = 'Fold level 8' })
keymap('n', 'z9', '<cmd>set foldlevel=9<cr>', { desc = 'Fold level 9' })
keymap('n', 'z0', '<cmd>set foldlevel=99<cr>', { desc = 'Fold level 99' })

-- All
keymap('', '<S-l>', '$', opts)
keymap('', '<S-h>', '^', opts)

keymap('n', 'BB', '<cmd>enew<cr>', opts)
keymap('n', 'BS', '<cmd>enew<cr><cmd>set filetype=json<cr>', opts)
keymap('n', 'BJ', '<cmd>enew<cr><cmd>set filetype=javascript<cr>', opts)
keymap('n', 'BT', '<cmd>enew<cr><cmd>set filetype=typescript<cr>', opts)
keymap('n', 'BV', '<cmd>enew<cr><cmd>set filetype=vue<cr>', opts)
keymap('n', 'BH', '<cmd>enew<cr><cmd>set filetype=html<cr>', opts)
keymap('n', 'BL', '<cmd>enew<cr><cmd>set filetype=lua<cr>', opts)

-- Normal --
-- Better window navigation
-- keymap('n', '<C-h>', '<C-w>h', opts)
-- keymap('n', '<C-j>', '<C-w>j', opts)
-- keymap('n', '<C-k>', '<C-w>k', opts)
-- keymap('n', '<C-l>', '<C-w>l', opts)

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

-- fzf-lua
keymap('t', '<esc>', [[<C-\><C-n>]])

-- keymap({ 'i', 'n', 'v' }, '<C-->', function()
--   require('user.converter').toggleColorFormat()
-- end, opts)

-- 聪明地使用命令行历史
-- keymap("c", "<C-n>", "<down>", opts)
-- keymap("c", "<C-p>", "<up>", opts)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
keymap('i', ',', ',<c-g>u')
keymap('i', '.', '.<c-g>u')
keymap('i', ';', ';<c-g>u')

keymap('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
keymap('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
keymap('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
keymap('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
keymap('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
keymap('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- save file
-- keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- function EnterOrIndentTag()
--   local file_type = vim.bo.filetype
--   local line = vim.fn.getline('.')
--   local col = vim.fn.getpos('.')[3]
--   local before = line:sub(col - 1, col - 1)
--   local after = line:sub(col, col)
--
--   if file_type == 'html' and before == '>' and after == '<' then
--     return vim.api.nvim_replace_termcodes('<CR><C-o>O', true, true, true)
--   elseif (file_type == 'css' or file_type == 'scss' or file_type == 'less') and before == '{' and after == '}' then
--     return vim.api.nvim_replace_termcodes('<CR><C-o>O', true, true, true)
--   elseif file_type == 'vue' and (before == '<' and after == '>') or (before == '{' and after == '}') then
--     return vim.api.nvim_replace_termcodes('<CR><C-o>O', true, true, true)
--   else
--     vim.api.nvim_replace_termcodes('<CR>', true, true, true)
--   end
-- end

-- keymap('i', '<CR>', EnterOrIndentTag, { noremap = true, expr = true })

-- vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", {desc="Close all buffers but the current one"}) -- https://stackoverflow.com/a/42071865/516188
