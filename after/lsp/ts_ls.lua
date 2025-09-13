local vue_language_server_path = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server'

local is_vue2 = require('utils.init').is_vue2_project()
local filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }

if not is_vue2 then
  table.insert(filetypes, 'vue')
end

local inlayHints = {
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = true,
}

---@type vim.lsp.Config
return {
  filetypes = filetypes,
  init_options = {
    locale = 'zh-CN',
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
    },
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
        enableForWorkspaceTypeScriptVersions = true,
      },
    },
  },
  settings = {
    javascript = { inlayHints = inlayHints },
    typescript = { inlayHints = inlayHints },
  },
  on_attach = function(client)
    if client.server_capabilities == nil then
      return
    end

    if vim.bo.filetype == 'vue' then
      client.server_capabilities.semanticTokensProvider.full = false
    else
      client.server_capabilities.semanticTokensProvider.full = true
    end
  end,
}
