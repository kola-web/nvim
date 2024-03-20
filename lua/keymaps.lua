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

-- Map j and k with v:count conditional for vertical movement
-- keymap({ 'n', 'x' }, 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true })
-- keymap({ 'n', 'x' }, '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true })
-- keymap({ 'n', 'x' }, 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true })
-- keymap({ 'n', 'x' }, '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true })

-- All
keymap('', '<S-l>', '$', opts)
keymap('', '<S-h>', '^', opts)

keymap('n', 'BB', '<cmd>enew<cr>', opts)
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
keymap('n', ']h', '/<template<cr>', opts)
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
