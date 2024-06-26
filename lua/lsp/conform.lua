local M = {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  opts = function()
    local util = require('conform.util')
    local prettier = { 'prettierd' }
    local eslint = { 'prettierd', 'eslint_d' }

    return {
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },

        javascript = { prettier },
        typescript = prettier,
        vue = prettier,
        html = { prettier },
        css = { prettier },
        scss = { prettier },
        wxss = { prettier },
        json = { prettier },
        yaml = { prettier },
        markdown = { prettier },

        toml = { 'taplo' },

        blade = { 'blade-formatter' },

        rust = { 'rustfmt' },

        nginx = { 'nginx-formatter' },
      },
      formatters = {
        ['blade-formatter'] = {
          prepend_args = { '-i', '2' },
        },
        ['nginx-formatter'] = {
          command = 'nginxbeautifier',
          args = { '--input', '$FILENAME' },
          stdin = false,
        },
      },
    }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

return M
