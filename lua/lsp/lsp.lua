local M = {
  'neovim/nvim-lspconfig',
  lazy = true,
  dependencies = {
    { 'mason-lspconfig.nvim' },
    { 'folke/neoconf.nvim', opts = { import = { vscode = false, coc = false, nlsp = false } } },
    { 'b0o/schemastore.nvim' },
  },
  opts = {},
}

function M.config()
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')
  local icons = require('utils.icons')

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

  lspconfig.nginx_language_server.setup({
    capabilities = lsp_capabilities,
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
