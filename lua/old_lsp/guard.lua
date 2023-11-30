local M = {
  'nvimdev/guard.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvimdev/guard-collection',
  },
}

M.config = function()
  local ft = require('guard.filetype')

  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    ignore_patterns = '%w_spec%.lua',
  })

  ft('wxml,html,json,jsonc,css,scss,less,markdown'):fmt('prettier')

  ft('typescript,javascript,javascriptreact,typescriptreact,vue'):fmt('prettier')

  -- ft("lua"):fmt({
  --   fn = function(buf,range)
  --     vim.lsp.buf.format({
  --       buffer = buf,
  --       range = range,
  --       async = true,
  --       name = "some server"
  --       filter = function(client) return client.name == "this" or client.name == "that" end
  -- })

  -- :fmt({
  --   fn = function()
  --     vim.cmd('EslintFixAll')
  --   end,
  -- })

  require('guard').setup({
    fmt_on_save = false,
    lsp_as_default_formatter = true,
  })
end

return M
