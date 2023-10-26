return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  -- filetypes = { 'typescript', 'javascript', 'vue' },
  init_options = {
    languageFeatures = {
      references = true,
      implementation = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      renameFileRefactoring = true,
      signatureHelp = true,
      completion = {
        defaultAttrNameCase = 'kebabCase',
        defaultTagNameCase = 'kebabCase',
      },
      inlayHints = true,
      diagnostics = true,
      codeLens = {
        showReferencesNotification = true,
      },
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
    css = { validate = false },
    scss = {
      validate = false,
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
    less = { validate = false },
  },
}
