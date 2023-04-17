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
keymap({ "n", "t" }, "<C-q>", "<C-w><C-w>", opts)

keymap("n", "<C-m>", "<Ignore><Plug>(matchup-%)", opts)
keymap("n", "<C-z>", "<nop>", opts)
keymap("n", "(", "<cmd>BufferLineMovePrev<cr>", opts)
keymap("n", ")", "<cmd>BufferLineMoveNext<cr>", opts)

-- vue jump
keymap("n", "]h", "/<template<cr>", opts)
keymap("n", "]H", "/</template<cr>", opts)
keymap("n", "]s", "/<script<cr>", opts)
keymap("n", "]S", "/</script<cr>", opts)
keymap("n", "]c", "/<style<cr>", opts)
keymap("n", "]C", "/</style<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<tab>", "::BufferLineCycleNext<CR><CR>", opts)
keymap("n", "<S-tab>", "::BufferLineCyclePrev<CR><CR>", opts)

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

-- Telescope
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- fzf-lua
keymap("t", "<esc>", [[<C-\><C-n>]])

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

