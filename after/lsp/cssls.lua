return {
  filetypes = { 'css', 'scss', 'less' },
  customData = { '.vscode/css-data.json' },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      validate = true,
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css-data.json') },
    },
    scss = {
      validate = true,
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css-data.json') },
    },
    less = {
      validate = true,
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css-data.json') },
    },
  },
}
