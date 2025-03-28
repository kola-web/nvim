return {
  root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git', '.svn'),
  filetypes = {
    'css',
    'eruby',
    'html',
    'javascript',
    'javascriptreact',
    'less',
    'sass',
    'scss',
    'pug',
    'typescriptreact',
    'blade',
  },
  init_options = {
    --- @type string[]
    excludeLanguages = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {
      ['bem.elementSeparator'] = '__',
      ['bem.modifierSeparator'] = '_',
      ['bem.shortElementPrefix'] = '-',
      ['css.intUnit'] = 'px',
      ['css.floatUnitr'] = 'px',
    },
    includeLanguages = {
      javascriptreact = 'html',
      typescriptreact = 'html',
      blade = 'html',
    },
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = 'always',
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = true,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {
      html = {
        filters = 'bem',
        self_closing_tag = 'xhtml',
        attr_case = 'lower',
        attr_quotes = 'lower',
      },
    },
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
    extensionsPath = {
      vim.fn.stdpath('config') .. '/emmet',
    },
  },
}
