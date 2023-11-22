local M = {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = function()
    local util = require('conform.util')
    return {
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        -- python = { 'isort', 'black' },
        -- Use a sub-list to run only the first available formatter
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        html = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        wxss = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        sh = { 'shfmt', 'shellcheck' },
        toml = { 'taplo' },
        php = { 'pint' },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    }
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

return M
