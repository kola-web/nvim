local colorscheme = 'tokyodark'

local init = function(theme)
  return function()
    if theme == colorscheme then
      vim.cmd.colorscheme(colorscheme)
    end
  end
end

local M = {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      style = 'storm',
      transparent = false,
      plugins = {
        markdown = true,
      },
    },
    init = init('tokyonight'),
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {},
    init = init('kanagawa'),
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    opts = {
      transparent = false,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    init = init('solarized-osaka'),
  },
  {
    'tiagovla/tokyodark.nvim',
    lazy = true,
    opts = {},
    init = init('tokyodark'),
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    opts = {},
    init = init('gruvbox'),
  },

  -- {
  --   'rebelot/kanagawa.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     style = 'storm',
  --     transparent = false,
  --     plugins = {
  --       markdown = true,
  --     },
  --   },
  --   init = function()
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'Mofiqul/dracula.nvim',
  --   opts = {},
  --   config = function(_, opts)
  --     require('dracula').setup(opts)
  --     vim.cmd([[colorscheme dracula]])
  --   end,
  -- },

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'olimorris/onedarkpro.nvim',
  --   config = function()
  --     -- vim.cmd([[colorscheme onedark]])
  -- },
  --   end,

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'oxfist/night-owl.nvim',
  --   config = function()
  --     require('night-owl').setup({})
  --     vim.cmd([[colorscheme night-owl]])
  --   end,
  -- },

  -- {
  --   priority = 1000,
  --   lazy = false,
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --     require('github-theme').setup({})
  --     vim.cmd('colorscheme github_dark_dimmed')
  --   end,
  -- },
}

-- vim.cmd('colorscheme tokyonight')
-- vim.cmd.colorscheme('tokyodark')

return M
