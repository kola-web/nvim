local M = {
  'simrat39/symbols-outline.nvim',
  event = 'VeryLazy',
  opts = function()
    local icons = require('user.nvim-dev-icons')
    local defaults = require('symbols-outline.config').defaults
    local opts = {
      symbols = {},
      symbol_blacklist = {},
    }

    for kind, symbol in pairs(defaults.symbols) do
      opts.symbols[kind] = {
        icon = icons.icons.kinds[kind] or symbol.icon,
        hl = symbol.hl,
      }
    end
    return opts
  end,
}

return M

