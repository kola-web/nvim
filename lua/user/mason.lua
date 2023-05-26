local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = true,
    },
    {
      "jayp0521/mason-null-ls.nvim",
      lazy = true
    }
  },
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

function M.config()
  require("mason").setup(settings)
  require("mason-lspconfig").setup {
    ensure_installed = require("utils.init").servers,
    automatic_installation = true,
  }
  require("mason-null-ls").setup {
    ensure_installed = require("utils.init").null_servers,
    automatic_installation = true,
  }
end

return M
