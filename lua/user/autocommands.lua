local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup "checktime",
  command = "checktime",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "Markdown",
  },
  callback = function()
    vim.cmd [[
      "autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
      inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
      inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
      inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
      inoremap <buffer> ,n ---<Enter><Enter>
      inoremap <buffer> ,b **** <++><Esc>F*hi
      inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
      inoremap <buffer> ,i ** <++><Esc>F*i
      inoremap <buffer> ,d `` <++><Esc>F`i
      inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
      inoremap <buffer> ,m - [ ] 
      inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
      inoremap <buffer> ,a [](<++>) <++><Esc>F[a
      inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
      inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
      inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
      inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
      inoremap <buffer> ,l --------<Enter>
    ]]
  end,
})

-- vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = "rounded",
--       source = "always",
--       prefix = " ",
--       scope = "cursor",
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end,
-- })
