local M = {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'mason.nvim',
      { 'mason-lspconfig.nvim' },
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

      require('mason-lspconfig').setup({
        ensure_installed = require('utils.init').servers,
        automatic_installation = false,
      })
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local server_config = {
            capabilities = capabilities,
            flags = { allow_incremental_sync = false },
          }

          local neoConfig = {}
          if server_name == 'emmet_language_server' then
            neoConfig = require('neoconf').get(server_name) or {}
          end

          local require_ok, conf_opts = pcall(require, 'lsp.' .. server_name)
          if require_ok then
            server_config = vim.tbl_deep_extend('force', conf_opts, neoConfig, server_config) or {}
          end

          lspconfig[server_name].setup(server_config)
        end,
      })

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
