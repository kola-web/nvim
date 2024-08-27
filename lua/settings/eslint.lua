return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'html',
    'markdown',
    'json',
    'jsonc',
    'yaml',
    'toml',
  },
  root_dir = require('lspconfig').util.root_pattern(
    'eslint.config.js',
    'eslint.config.cjs',
    'eslint.config.mjs',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json'
  ),
  settings = {
    codeAction = {
      showDocumentation = {
        enable = true,
      },
    },
    useFlatConfig = true,
    quiet = true,
    rulesCustomizations = {
      { rule = 'style/*', severity = 'off' },
      { rule = 'format/*', severity = 'off' },
      { rule = '*-indent', severity = 'off' },
      { rule = '*-spacing', severity = 'off' },
      { rule = '*-spaces', severity = 'off' },
      { rule = '*-order', severity = 'off' },
      { rule = '*-dangle', severity = 'off' },
      { rule = '*-newline', severity = 'off' },
      { rule = '*quotes', severity = 'off' },
      { rule = '*semi', severity = 'off' },
    },
  },
}
