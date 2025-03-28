-- creativenull/efmls-configs-nvim

local stylua = require('efmls-configs.formatters.stylua')
local shfmt = require('efmls-configs.formatters.shfmt')
local shellcheck = require('efmls-configs.linters.shellcheck')
local prettier = require('efmls-configs.formatters.prettier')
local eslint = require('efmls-configs.linters.eslint')

local languages = {
  sh = { shfmt, shellcheck },
  lua = { stylua },
  typescript = { eslint },
  javascript = { prettier, eslint },
  typescriptreact = { prettier, eslint },
  javascriptreact = { prettier, eslint },
  vue = { prettier, eslint },
  yaml = { prettier },
  json = { prettier },
  html = { prettier },
  wxml = { prettier },
  scss = { prettier },
  css = { prettier },
  markdown = { prettier },
}

return {
  init_options = { documentFormatting = true },
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
}
