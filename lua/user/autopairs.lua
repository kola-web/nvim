local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    enable_check_bracket_line = false,
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)
  end,
}

return M
