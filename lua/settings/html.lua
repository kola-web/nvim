return {
  filetypes = { 'html' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = false,
    customData = {
      vim.fn.stdpath('config') .. '/data/wxml.html-data.json',
    },
  },
  settings = {
    customData = {
      vim.fn.stdpath('config') .. '/data/wxml.html-data.json',
    },
  },
}
