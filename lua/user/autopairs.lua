local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
  }, -- this ischeck_ts equalent to setup({}) function
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}

return M
