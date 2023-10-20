local lsp = require('user.lsp')
local M = {
  'kola-web/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities,
    settings = {
      expose_as_code_action = 'all',
      locale = 'zh-CN',
      tsserver_file_preferences = {
        importModuleSpecifierPreference = 'non-relative',
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

M.config = function(_, opts)
  if not require('neoconf').get('tsserver' .. '.disable') then
    require('typescript-tools').setup(opts)
  end
end

return M
