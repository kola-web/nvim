return {
  filetypes = {
    'css',
    'eruby',
    'html',
    'javascript',
    'javascriptreact',
    'less',
    'sass',
    'scss',
    'svelte',
    'pug',
    'typescriptreact',
    'vue',
  },
  init_options = {
    --- @type string[]
    excludeLanguages = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {
      bem = {
        elementSeparator = '__',
        modifierSeparator = '_',
        shortElementPrefix = '-',
      },
      css = {
        intUnit = 'rpx',
        floatUnitr = 'rpx',
      },
    },
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = false,
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
  },
}
