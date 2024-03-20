local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    enable_check_bracket_line = false,
  }, -- this ischeck_ts equalent to setup({}) function
  config = function(_, opts)
    -- verbose imap <cr>
    require('nvim-autopairs').setup(opts)
  end,
}

return M
