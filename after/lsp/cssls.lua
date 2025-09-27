return {
  filetypes = { 'css', 'scss', 'less' },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
    scss = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
    less = {
      customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/custom-data/css-data.json') },
    },
  },
}
