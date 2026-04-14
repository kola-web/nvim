local conform_ok, conform = pcall(require, 'conform')
if not conform_ok then
  return
end

local prettier = { 'prettier', stop_after_first = true }

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

conform.setup({
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
    nginx = { 'nginxfmt' },
  },
  formatters = {
    ['blade-formatter'] = {
      prepend_args = { '-i', '2' },
    },
  },
})

vim.keymap.set('n', '<leader>m', function()
  require('utils.init').conformFormat()
end, { desc = 'Format code' })
