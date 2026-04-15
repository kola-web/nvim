local M = {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    opts = {
      ensure_installed = vim.list_extend(require('utils.init').null_servers, require('utils.init').servers),
    },
  },
}

return M
