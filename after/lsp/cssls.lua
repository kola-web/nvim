return {
  filetypes = { 'css', 'scss', 'less' },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      customdata = { vim.fn.stdpath('config') .. '/custom-data/css.css-data.json' },
    },
    scss = {
      customdata = { vim.fn.stdpath('config') .. '/custom-data/css.css-data.json' },
    },
    less = {
      customdata = { vim.fn.stdpath('config') .. '/custom-data/css.css-data.json' },
    },
  },
}
