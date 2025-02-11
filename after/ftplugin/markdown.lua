local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true, buffer = true }

keymap("i", ",f", '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', opts)
keymap("i", "<c-e>", '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', opts)
keymap("i", ",w", '<++><CR>:nohlsearch<CR>"_c5l<CR>', opts)
keymap("i", ",n", "---<Enter><Enter>", opts)
keymap("i", ",b", "**** <++><Esc>F*hi", opts)
keymap("i", ",s", "~~~~ <++><Esc>F~hi", opts)
keymap("i", ",i", "** <++><Esc>F*i", opts)
keymap("i", ",d", "`` <++><Esc>F`i", opts)
keymap("i", ",c", "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA", opts)
keymap("i", ",m", "- [ ] ", opts)
keymap("i", ",p", "![](<++>) <++><Esc>F[a", opts)
keymap("i", ",a", "[](<++>) <++><Esc>F[a", opts)
keymap("i", ",1", "#<Space><Enter><++><Esc>kA", opts)
keymap("i", ",2", "##<Space><Enter><++><Esc>kA", opts)
keymap("i", ",3", "###<Space><Enter><++><Esc>kA", opts)
keymap("i", ",4", "####<Space><Enter><++><Esc>kA", opts)
keymap("i", ",l", "--------<Enter>", opts)
