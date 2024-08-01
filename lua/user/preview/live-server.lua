local M = {
  'barrett-ruth/live-server.nvim',
  build = 'npm i -g live-server',
  cmd = { 'LiveServerStart', 'LiveServerStop', 'LiveServerToggle' },
  config = true,
  keys = {
    {
      '<leader>ph',
      '<cmd>LiveServerToggle<cr>',
      desc = 'live-server',
    },
  },
}

return M
