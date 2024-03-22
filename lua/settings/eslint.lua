return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    vim.api.nvim_create_autocmd('BufWritePost', {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup(('eslint_fix_%d'):format(bufnr), { clear = true }),
      callback = function()
        if vim.fn.exists(':EslintFixAll') > 0 then
          vim.cmd.EslintFixAll()
        end
      end,
    })
  end,
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
    codeActionOnSave = {
      enable = true,
      mode = 'all',
    },
    experimental = {
      useFlatConfig = true,
    },
    format = true,
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
