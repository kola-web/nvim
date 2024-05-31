local function augroup(name)
  return vim.api.nvim_create_augroup('kola_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- local filetype = vim.bo[bufnr].filetype
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

    -- if client and client.server_capabilities.documentSymbolProvider then
    --   if filetype == 'vue' and client.name == 'tsserver' then
    --     return
    --   end
    --   require('nvim-navic').attach(client, bufnr)
    --   vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    -- end

    -- diagnostic
    local diagnostic_goto = function(next, severity)
      local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
      severity = severity and vim.diagnostic.severity[severity] or nil
      return function()
        go({ severity = severity })
      end
    end

    local keymap = vim.keymap.set
    local function createKeymap(mode, key, cmd, desc)
      keymap(mode, key, cmd, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    createKeymap('n', 'gr', '<cmd>Trouble lsp_references focus=true<CR>', 'GoTo references')

    createKeymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'GoTo definition')
    createKeymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'GoTo declaration')
    createKeymap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'GoTo type_definition')
    -- createKeymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
    createKeymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'GoTo implementation')
    -- createKeymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', 'GoTo references')
    createKeymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Float diagnostic')
    -- createKeymap('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
    -- createKeymap('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
    createKeymap('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
    createKeymap('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
    createKeymap('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
    createKeymap('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')
    createKeymap('n', '<leader>lI', '<cmd>LspInfo<cr>', 'lspInfo')
    createKeymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', 'Lsp incoming_calls')
    createKeymap('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', 'Lsp outgoing_calls')
    createKeymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
    createKeymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
    createKeymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature help')
    createKeymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Setloclist')
    createKeymap('n', '<leader>lm', '<cmd>EslintFixAll<CR>', 'EslintFixAll')
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
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
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
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_unlisted'),
  pattern = { 'man' },
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
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--   group = augroup('auto_create_dir'),
--   callback = function(event)
--     if event.match:match('^%w%w+:[\\/][\\/]') then
--       return
--     end
--     local file = vim.uv.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
--   end,
-- })

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

