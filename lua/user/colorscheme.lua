local M = {
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = { style = 'storm', transparent = false },
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

  -- {
  --   'craftzdog/solarized-osaka.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = false,
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
  --   'rebelot/kanagawa.nvim',
  --   config = function()
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },
}

return M
