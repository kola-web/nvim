local M = {
  'windwp/nvim-ts-autotag',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 5,
          severity_limit = 'Warning',
        },
        update_in_insert = true,
      })
    require('nvim-ts-autotag').setup(opts)
  end,
}

return M
