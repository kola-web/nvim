local M = {
  'neovim/nvim-lspconfig',
  lazy = true,
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'folke/neoconf.nvim', opts = { import = { vscode = false, coc = false, nlsp = false } } },
    { 'folke/neodev.nvim', config = true },

    { 'b0o/schemastore.nvim' },

    { 'SmiteshP/nvim-navic', opts = { highlight = true, icons = require('user.nvim-dev-icons').icons.kinds } },
  },
  opts = {
    inlay_hints = {
      enabled = true,
    },
  },
}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.config()
  local lspconfig = require('lspconfig')
  local icons = require('user.nvim-dev-icons').icons

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      local server_config = {
        capabilities = lsp_capabilities,
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

  local config = {
    virtual_lines = true,
    virtual_text = {
      spacing = 4,
      source = 'always',
      prefix = '●',
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
    },
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = sign.name })
  end

  vim.diagnostic.config(config)
end

return M
