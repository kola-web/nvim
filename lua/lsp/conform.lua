local M = {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  opts = function()
    local util = require('conform.util')
    local prettier = { 'prettier', stop_after_first = true }
    -- local prettierd = { 'prettierd', stop_after_first = true }

    return {
      format = {
        timeout_ms = 10000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        sh = { 'shfmt' },

        javascript = prettier,
        typescript = prettier,
        vue = prettier,
        html = prettier,
        css = prettier,
        scss = prettier,
        wxss = prettier,
        json = prettier,
        jsonc = prettier,
        yaml = {},
        markdown = prettier,

        toml = { 'taplo' },

        blade = { 'blade-formatter' },

        rust = { 'rustfmt' },

        python = { 'isort', 'black' },

        php = { 'php_cs_fixer' },
      },
      formatters = {
        ['blade-formatter'] = {
          prepend_args = { '-i', '2' },
        },
      },
    }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    {
      '<leader>m',
      function()
        require('utils.init').conformFormat()
      end,
      desc = 'format',
    },
  },
}

return M
