local M = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPre',
}

M.opts = {
  indent = {
    char = '│',
    tab_char = '│',
  },
  scope = { enabled = false },
  exclude = {
    buftypes = { 'terminal', 'nofile' },
    filetypes = {
      'help',
      'alpha',
      'dashboard',
      'neo-tree',
      'Trouble',
      'lazy',
      'mason',
      'notify',
      'toggleterm',
      'lazyterm',
    },
  },
}

return M
