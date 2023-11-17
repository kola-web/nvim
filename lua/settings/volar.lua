-- Language server `volar` does not support command `editor.action.showReferences`. This command may require a client extension.
local is_vue = require('utils.init').is_vue
return {
  -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  filetypes = is_vue()
      and { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    or { 'vue' },
  init_options = {
    locale = 'zh-CN',
    languageFeatures = {
      callHierarchy = true,
      codeAction = true,
      codeLens = true,
      completion = {
        defaultAttrNameCase = 'kebabCase',
        defaultTagNameCase = 'both',
      },
      definition = true,
      diagnostics = true,
      documentHighlight = true,
      documentLink = true,
      hover = true,
      implementation = true,
      references = true,
      rename = true,
      renameFileRefactoring = true,
      schemaRequestService = true,
      semanticTokens = false,
      signatureHelp = true,
      typeDefinition = true,
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
      },
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = {
          enabled = 'all',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = true,
        },
        enumMemberValues = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
      },
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
    },
  },
}
