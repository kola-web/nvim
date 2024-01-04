local M = {
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = { style = 'moon', transparent = true },
  --   config = function(_, opts)
  --     require('tokyonight').setup(opts)
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },
  {
    priority = 1000,
    lazy = false,
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    opts = {
      extra_groups = {},
      exclude_groups = {
        'CursorLine',
      }, -- table: groups you don't want to clear
    },
    config = true,
  },
}

return M
