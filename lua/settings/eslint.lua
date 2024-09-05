return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'html',
    'markdown',
    'json',
    'jsonc',
    'yaml',
    'toml',
    'xml',
    'gql',
    'graphql',
    'astro',
    'svelte',
    'css',
    'less',
    'scss',
    'pcss',
    'postcss',
  },
  -- root_dir = require('lspconfig').util.root_pattern('eslint.config.js', 'eslint.config.cjs', 'eslint.config.mjs'),
  settings = {
    rulesCustomizations = {
      { rule = 'style/*', severity = 'off', fixable = true },
      { rule = 'format/*', severity = 'off', fixable = true },
      { rule = '*-indent', severity = 'off', fixable = true },
      { rule = '*-spacing', severity = 'off', fixable = true },
      { rule = '*-spaces', severity = 'off', fixable = true },
      { rule = '*-order', severity = 'off', fixable = true },
      { rule = '*-dangle', severity = 'off', fixable = true },
      { rule = '*-newline', severity = 'off', fixable = true },
      { rule = '*quotes', severity = 'off', fixable = true },
      { rule = '*semi', severity = 'off', fixable = true },
    },
  },
}
