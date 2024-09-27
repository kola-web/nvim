local M = {
  'ray-x/web-tools.nvim',
  build = 'npm i -g browser-sync',
  opts = {},
  keys = {
    {
      '<leader>ph',
      '<cmd>BrowserPreview {-f}<cr>',
      desc = 'live-server',
    },
  },
}

return M
