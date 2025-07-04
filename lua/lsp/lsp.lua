local M = {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'mason-org/mason-lspconfig.nvim' },
      'mason-org/mason-lspconfig.nvim',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', opts = {} },
      { 'b0o/schemastore.nvim' },
    },
    opts = {},
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      local icons = require('utils.icons')

      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      vim.lsp.config('*', {
        capabilities = capabilities,
        flags = { allow_incremental_sync = false },
      })

      local emmet_language_server = require('neoconf').get('emmet_language_server') or {}
      vim.lsp.config('emmet_language_server', emmet_language_server)

      require('mason-lspconfig').setup({
        ensure_installed = require('utils.init').servers,
        automatic_enable = true,
      })

      local neoConfig = require('neoconf').get('emmet_language_server') or {}

      local config = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
          current_line = false,
        },
        virtual_lines = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
      }

      vim.diagnostic.config(config)
    end,
  },
}

return M
