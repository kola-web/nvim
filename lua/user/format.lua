local M = {
  "stevearc/conform.nvim",
  eneny = "VeryLazy"
}

M.config = function()
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      vue = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      scss = { { 'prettierd', 'prettier' } },
      wxss = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },

      sh = { 'shfmt', 'shellcheck' },

      toml = { 'taplo' },
    },
  })
end

return M
