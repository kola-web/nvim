vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/folke/neoconf.nvim',
  'https://github.com/b0o/schemastore.nvim',
})

local icons = require('utils.icons')

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    current_line = true,
    virtual_lines = true,
  },
})

local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end

local function on_lsp_attach(args)
  local buffer = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local keymap = vim.keymap.set

  keymap('n', 'gl', vim.diagnostic.open_float, { desc = 'Float diagnostic', buffer = buffer })
  keymap('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action', buffer = buffer })
  keymap('n', '<leader>lc', vim.lsp.codelens.run, { desc = 'Run Codelens', buffer = buffer })
  keymap('n', '<leader>lR', function()
    Snacks.rename.rename_file()
  end, { desc = 'Rename file', buffer = buffer })
  keymap('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename', buffer = buffer })
  keymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = 'diagnostic', buffer = buffer })
  keymap('n', '<leader>le', '<cmd>EslintFixAll<CR>', { desc = 'EslintFixAll', buffer = buffer })
  keymap('n', '<leader>lo', function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports' } } })
  end, { desc = 'Organize Imports', buffer = buffer })
  keymap('n', ']]', function()
    Snacks.words.jump(vim.v.count1)
  end, { desc = 'Next Reference', buffer = buffer })
  keymap('n', '[[', function()
    Snacks.words.jump(-vim.v.count1)
  end, { desc = 'Prev Reference', buffer = buffer })

  keymap('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic', buffer = buffer })
  keymap('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic', buffer = buffer })
  keymap('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error', buffer = buffer })
  keymap('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error', buffer = buffer })
  keymap('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning', buffer = buffer })
  keymap('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning', buffer = buffer })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kola-lsp-attach', { clear = true }),
  callback = on_lsp_attach,
})

local has_blink, blink = pcall(require, 'blink.cmp')
local capabilities = vim.tbl_deep_extend('force', {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}, vim.lsp.protocol.make_client_capabilities(), has_blink and blink.get_lsp_capabilities() or {})

vim.lsp.config('*', {
  capabilities = vim.deepcopy(capabilities),
  root_markers = { '.git' },
})

local emmet_language_server = require('neoconf').get('emmet_language_server') or {}
vim.lsp.config('emmet_language_server', emmet_language_server)

local is_vue2 = require('utils.init').is_vue2_project()
local servers = require('utils.init').servers

for _, server in pairs(servers) do
  local status = true
  if server == 'vue_ls' and is_vue2 then
    status = false
  end
  if server == 'vuels' and not is_vue2 then
    status = false
  end
  vim.lsp.enable(server, status)
end

vim.keymap.set('n', '<leader>ln', '<cmd>Neoconf<cr>', { desc = 'Neoconf' })
vim.keymap.set('n', '<leader>L', '<cmd>LspRestart<cr>', { desc = 'lspRestart' })
