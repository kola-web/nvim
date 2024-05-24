local M = {
  'barrett-ruth/live-server.nvim',
  build = 'npm i -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true,
  keys = {
    {
      '<leader>ph',
      function()
        require('live-server').toggle()
      end,
      desc = 'live-server',
    },
  },
}

return M
