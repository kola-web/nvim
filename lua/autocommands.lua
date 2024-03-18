-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local keymap = vim.keymap.set
    -- stylua: ignore start
    keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo declaration" })
    keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo definition" })
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Hover" })
    keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo implementation" })
    keymap("n", "gr", "<cmd>lua require('trouble').toggle('lsp_references')<CR>", { buffer=buffer, noremap = true, silent = true, desc = "GoTo references" })
    keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Float diagnostic" })
    keymap("n", "<leader>lI", "<cmd>LspInfo<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Mason" })
    keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Lsp incoming_calls" })
    keymap("n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Lsp outgoing_calls" })
    keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Code action" })
    keymap("n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Next diagnostic" })
    keymap("n", "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Previous diagnostic" })
    keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer=buffer, noremap = true, silent = true, desc = "Rename" })
    keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Signature help" })
    keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Setloclist" })
    keymap("n", "<leader>ld", "<cmd>TroubleToggle<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Setloclist" })
    keymap("n", "<leader>lm", "<cmd>EslintFixAll<CR>", { buffer=buffer, noremap = true, silent = true, desc = "Setloclist" })
    -- stylua: ignore end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})


-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'sagadiagnostc',
    'dropbar_menu',
    'lazy',
    'noice',
    'DressingSelect',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})


-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- 禁止新行注释
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Disable New Line Comment',
})

-- 更加智能的当前行高亮
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = augroup('cursorline'),
  callback = function()
    vim.opt.cursorline = true
  end,
  desc = 'set cursorline',
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.cursorline = false
  end,
  desc = 'set nocursorline',
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
