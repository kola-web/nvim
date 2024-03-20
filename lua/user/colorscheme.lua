local M = {
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = { style = 'moon', transparent = false },
  --   config = function(_, opts)
  --     require('tokyonight').setup(opts)
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },

  -- {
  --   'craftzdog/solarized-osaka.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = 'transparent',
  --       floats = 'transparent',
  --     },
  --   },
  --   config = function(_, opts)
  --     require('solarized-osaka').setup(opts)
  --     vim.cmd([[colorscheme solarized-osaka]])
  --   end,
  -- },

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'sainnhe/gruvbox-material',
  --   config = function()
  --     vim.cmd([[colorscheme gruvbox-material]])
  --   end,
  -- },

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'rebelot/kanagawa.nvim',
  --   config = function()
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require('gruvbox').setup(opts)
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}

return M
