-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- All
keymap("", "<S-l>", "$", opts)
keymap("", "<S-h>", "^", opts)

keymap("n", "B", "<cmd>enew<cr>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-m>", "%", opts)
-- keymap("n", "<C-z>", "<nop>", opts)
-- keymap("n", "(", "<cmd>BufferLineMovePrev<cr>", opts)
-- keymap("n", ")", "<cmd>BufferLineMoveNext<cr>", opts)
keymap("n", "(", "<Plug>(cokeline-switch-prev)", opts)
keymap("n", ")", "<Plug>(cokeline-switch-next)", opts)

-- vue jump
keymap("n", "]h", "/<template<cr>", opts)
keymap("n", "]H", "/</template<cr>", opts)
keymap("n", "]s", "/<script<cr>", opts)
keymap("n", "]S", "/</script<cr>", opts)
keymap("n", "]c", "/<style<cr>", opts)
keymap("n", "]C", "/</style<cr>", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<tab>", "<Cmd>BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<tab>", "<Plug>(cokeline-focus-prev)", opts)
keymap("n", "<S-tab>", "<Plug>(cokeline-focus-next)", opts)

-- smart n/N
keymap("n", "n", vim.v.searchforward == 1 and "n" or "N", opts)
keymap("n", "N", vim.v.searchforward == 1 and "N" or "n", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- substitute
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", opts)
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", opts)
keymap("n", "S", "<cmd>lua require('substitute').eol()<cr>", opts)
keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", opts)
vim.keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').operator()<cr>", opts)
vim.keymap.set("n", "sxx", "<cmd>lua require('substitute.exchange').line()<cr>", opts)
vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", opts)
vim.keymap.set("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>", opts)

--abolish.vim
keymap("n", "ga", "<Plug>(abolish-coerce-word)")
keymap("v", "ga", "<Plug>(abolish-coerce)")

keymap("x", "gx", "<Plug>(EasyAlign)")
keymap("n", "gx", "<Plug>(EasyAlign)")


-- fzf-lua
keymap("t", "<esc>", [[<C-\><C-n>]])

-- 聪明地使用命令行历史
-- keymap("c", "<C-n>", "<down>", opts)
-- keymap("c", "<C-p>", "<up>", opts)
