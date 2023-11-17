return {
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'typescriptreact',
    'php',
    'vue',
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
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = 'always',
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
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
