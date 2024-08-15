local M = {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPre',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = '▏',
        tab_char = '▏',
      },
      scope = { enabled = true },
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
    },
  },
}

return M
