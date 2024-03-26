return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    locale = 'zh-CN',
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
    },
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = os.getenv('PNPM_HOME') .. '/global/5/node_modules/@vue/typescript-plugin',
        languages = { 'typescript', 'vue', 'javascript' },
      },
    },
  },
  single_file_support = false,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'literal',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
