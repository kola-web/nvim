vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})
local conform = require('conform')

-- 从文件所在目录向上查找 node_modules 中的包（判断项目是否装了 prettier-plugin-mp）
local function find_up(dir, name)
  local p = dir .. '/node_modules/' .. name
  if vim.uv.fs_stat(p) then
    return p
  end
  local parent = vim.fn.fnamemodify(dir, ':h')
  if parent == dir then
    return nil
  end
  return find_up(parent, name)
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
    html = prettier, -- wxml 复用 html filetype，prettier 按 html 格式化（见下方 args 的 wxml 分支）
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
    -- wxml：项目装有 prettier-plugin-mp → 显式 --plugin 加载（无需 .prettierrc 声明）；
    -- 未装 → 退回 html 兼容模式
    prettier = {
      args = function(ctx)
        local args = { '--stdin-filepath', '$FILENAME' }
        if vim.fn.fnamemodify(ctx.filename, ':e') == 'wxml' then
          local plugin = find_up(vim.fn.fnamemodify(ctx.filename, ':p:h'), 'prettier-plugin-mp')
          if plugin then
            vim.list_extend(args, { '--plugin', plugin })
          else
            vim.list_extend(args, { '--parser', 'html' })
          end
        end
        return args
      end,
    },
  },
})

vim.keymap.set('n', '<leader>m', function()
  require('utils.init').conformFormat()
end, { desc = 'Format code' })
