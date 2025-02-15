local M = {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    opts = {
      workspaces = {
        {
          name = 'note',
          path = '~/note',
        },
      },
      ui = {
        enabled = false,
      },
    },
  },
}

return M
