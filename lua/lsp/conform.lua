local M = {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  opts = function()
    local util = require('conform.util')
    local prettier = { 'prettier' }
    local eslintOrPrettier = function()
      if require('utils.init').is_eslint() then
        return {}
      else
        return { prettier }
      end
    end

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

        javascript = eslintOrPrettier,
        typescript = eslintOrPrettier,
        vue = eslintOrPrettier,
        html = { prettier },
        css = { prettier },
        scss = { prettier },
        wxss = { prettier },
        json = { prettier },
        yaml = { prettier },
        markdown = { prettier, 'injected' },
        norg = { 'injected' },

        toml = { 'taplo' },

        php = { 'pint' },
      },
      formatters = {
        eslint_d = {
          args = { '--fix-to-stdout', '--stdin', '--stdin-filename', '$FILENAME', 'restart' },
          env = {
            ESLINT_USE_FLAT_CONFIG = 'true',
          },
        },
        eslint = {
          command = function()
            vim.cmd('EslintFixAll')
            return ''
          end,
          cwd = require('conform.util').root_file({
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc.json',
            'eslint.config.js',
          }),
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
