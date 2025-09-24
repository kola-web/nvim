return {
  filetypes = { 'css', 'scss', 'less' },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      experimental = {
        customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css.css-data.json') },
      },
    },
    scss = {
      experimental = {
        customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css.css-data.json') },
      },
    },
    less = {
      experimental = {
        customData = { vim.fn.expand(vim.fn.stdpath('config') .. '/html/css.css-data.json') },
      },
    },
  },
}
