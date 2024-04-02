local M = {
  'barrett-ruth/live-server.nvim',
  build = 'pnpm add -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true,
  keys = {
    {
      '<leader>ph',
      function()
        require('live-server').toggle()
      end,
      desc = 'Noice Last Message',
    },
  },
}

return M
