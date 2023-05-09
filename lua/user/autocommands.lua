vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "Jaq",
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "Markdown",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = {
--     "Markdown",
--   },
--   callback = function()
--     vim.cmd [[
--       "autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
--       inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
--       inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
--       inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
--       inoremap <buffer> ,n ---<Enter><Enter>
--       inoremap <buffer> ,b **** <++><Esc>F*hi
--       inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
--       inoremap <buffer> ,i ** <++><Esc>F*i
--       inoremap <buffer> ,d `` <++><Esc>F`i
--       inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
--       inoremap <buffer> ,m - [ ] 
--       inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
--       inoremap <buffer> ,a [](<++>) <++><Esc>F[a
--       inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
--       inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
--       inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
--       inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
--       inoremap <buffer> ,l --------<Enter>
--     ]]
--   end,
-- })

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     local hl_groups = {
--       "Normal",
--       "SignColumn",
--       "NormalNC",
--       "TelescopeBorder",
--       "NvimTreeNormal",
--       "NvimTreeNormalNC",
--       "EndOfBuffer",
--       "MsgArea",
--     }
--     for _, name in ipairs(hl_groups) do
--       vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
--     end
--   end,
-- })
vim.opt.fillchars = "eob: "
