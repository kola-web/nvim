local M = {
  'echasnovski/mini.indentscope',
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = 'VeryLazy',
  opts = {
    -- symbol = "▏",
    symbol = '│',
    draw = {
      animation = nil,
    },
    options = { try_as_border = false, indent_at_cursor = false },
  },
}

return M
