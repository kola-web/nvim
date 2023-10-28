-- Language server `volar` does not support command `editor.action.showReferences`. This command may require a client extension.
return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  -- filetypes = { 'typescript', 'javascript', 'vue' },
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
    },
  },
}
