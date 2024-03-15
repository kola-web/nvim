local M = {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  opts = function()
    local util = require('conform.util')
    local prettier = { 'prettier' }
    local eslint = { 'prettier', 'eslint_d' }

    -- os.execute('ESLINT_USE_FLAT_CONFIG=true ' .. vim.fn.stdpath('data') .. '/mason/bin/eslint_d restart')
    -- local eslintOrPrettier = function()
    --   if require('utils.init').is_eslint() then
    --     return eslint
    --   else
    --     return prettier
    --   end
    -- end

    return {
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
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
      },
      formatters = {
        ['blade-formatter'] = {
          prepend_args = { '-i', '2' },
        },
      },
    }
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

return M
