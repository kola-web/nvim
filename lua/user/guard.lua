local M = {
  'nvimdev/guard.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

M.config = function()
  local ft = require('guard.filetype')

  -- ft('lua'):fmt({
  --   cmd = 'stylua',
  --   args = { '-' },
  --   stdin = true,
  --   ignore_patterns = '%w_spec%.lua',
  -- })
  ft(
    'typescript,javascript,javascriptreact,typescriptreact,vue,wxml,html,json,jsonc,css,scss,less,markdown'
  ):fmt('prettier')

  require('guard').setup({
    fmt_on_save = false,
    lsp_as_default_formatter = true,
  })
end

return M
