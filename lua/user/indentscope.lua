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
  init = function()
    -- require('mini.indentscope').gen_animation.none()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}

return M
