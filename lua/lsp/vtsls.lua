local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server' .. '/node_modules/@vue/typescript-plugin'

return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_typescript_plugin,
            languages = { 'typescript', 'javascript', 'vue' },
            enableForWorkspaceTypeScriptVersions = true,
            configNamespace = 'typescript',
          },
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}
