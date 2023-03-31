local fun = require 'user.function'
local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end

return {
  filetypes = fun.is_vue() and { 'null' } or { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  init_options = {
    hostInfo = 'neovim',
    locale = 'zh-CN',
  },
  commands = {
    -- 使用 :OrganizeImports 对import进行排序
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  },
}
