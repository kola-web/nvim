local M = {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'mason.nvim',
    { 'mason-lspconfig.nvim' },
    { 'folke/neoconf.nvim', cmd = 'Neoconf', opts = {} },
    { 'b0o/schemastore.nvim' },
    -- { 'saghen/blink.cmp' },
  },
  opts = {},
}

function M.config()
  local lspconfig = require('lspconfig')
  local icons = require('utils.icons')

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.name == 'eslint' then
        client.server_capabilities.documentFormattingProvider = true
      end

      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end

      local keymap = vim.keymap.set
      local function createKeymap(mode, key, cmd, desc)
        keymap(mode, key, cmd, { buffer = buffer, noremap = true, silent = true, desc = desc })
      end

      createKeymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature help')
      createKeymap('n', 'gr', '<cmd>Trouble lsp_references<CR>', 'GoTo references')
      createKeymap('n', 'gd', '<cmd>Trouble lsp_definitions<CR>', 'GoTo definition')
      createKeymap('n', 'gD', '<cmd>Trouble lsp_declarations<CR>', 'GoTo declaration')
      createKeymap('n', 'go', '<cmd>Trouble lsp<CR>', 'lsp')
      createKeymap('n', 'gi', '<cmd>Trouble lsp_implementations<CR>', 'GoTo implementation')
      createKeymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Float diagnostic')
      createKeymap('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
      createKeymap('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
      createKeymap('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
      createKeymap('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
      createKeymap('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
      createKeymap('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')
      createKeymap('n', '<leader>lI', '<cmd>LspInfo<cr>', 'lspInfo')
      createKeymap('n', '<leader>li', '<cmd>Trouble lsp_incoming_calls<cr>', 'Lsp incoming_calls')
      createKeymap('n', '<leader>lo', '<cmd>Trouble lsp_outgoing_calls<cr>', 'Lsp outgoing_calls')
      createKeymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
      createKeymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
      createKeymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Setloclist')
      createKeymap('n', '<leader>lm', '<cmd>EslintFixAll<CR>', 'EslintFixAll')
    end,
  })

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      local server_config = {
        -- capabilities = require('blink.cmp').get_lsp_capabilities(),
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        flags = { allow_incremental_sync = false },
      }

      local neoConfig = {}
      if server_name == 'emmet_language_server' then
        neoConfig = require('neoconf').get(server_name) or {}
      end

      local require_ok, conf_opts = pcall(require, 'settings.' .. server_name)
      if require_ok then
        server_config = vim.tbl_deep_extend('force', conf_opts, neoConfig, server_config) or {}
      end

      lspconfig[server_name].setup(server_config)
    end,
  })

  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = sign.name })
  end

  local config = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = '●',
    },
    severity_sort = true,
  }

  vim.diagnostic.config(config)
end

return M
