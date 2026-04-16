vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
})

local mason_servers = require('utils.init').null_servers
local mason_lspconfig_servers = require('utils.init').servers

require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

require('mason-tool-installer').setup({
  ensure_installed = vim.list_extend(mason_servers, mason_lspconfig_servers),
})
