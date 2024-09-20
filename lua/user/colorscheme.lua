local M = {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   opts = {
  --     integrations = {
  --       cmp = true,
  --       gitsigns = true,
  --       treesitter = true,
  --       notify = false,
  --       mini = {
  --         enabled = true,
  --         indentscope_color = '',
  --       },
  --     },
  --   },
  --   init = function()
  --     vim.cmd([[colorscheme catppuccin]])
  --   end,
  -- },

  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     style = 'storm',
  --     transparent = false,
  --     plugins = {
  --       markdown = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     require('tokyonight').setup(opts)
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },

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
  --   'ellisonleao/gruvbox.nvim',
  --   config = function()
  --     vim.cmd([[colorscheme gruvbox]])
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
  --   init = function()
  --     vim.cmd([[colorscheme solarized-osaka]])
  --   end,
  -- },

  -- {
  --   'rebelot/kanagawa.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   init = function(_, opts)
  --     vim.cmd([[colorscheme kanagawa]])
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
