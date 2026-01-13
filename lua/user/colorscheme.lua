-- local colorscheme = 'catppuccin'
local colorscheme = 'gruvbox'
-- local colorscheme = 'gruvbox-material'
-- local colorscheme = 'tokyonight'
-- local colorscheme = 'kanagawa'
-- local colorscheme = 'everforest'
-- local colorscheme = 'solarized-osaka'
-- local colorscheme = 'monokai-pro'

local init = function(theme)
  return function()
    if theme == colorscheme then
      vim.cmd.colorscheme(colorscheme)
    end
  end
end

local M = {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = init('catppuccin'),
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      -- style = 'storm',
      -- transparent = false,
      -- plugins = {
      --   markdown = true,
      -- },
    },
    init = init('tokyonight'),
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    init = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      init('gruvbox-material')()
    end,
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
  {
    'Mofiqul/dracula.nvim',
    lazy = true,
    opts = {},
    init = init('dracula'),
  },
  {
    'sainnhe/everforest',
    lazy = true,
    opts = {},
    init = function()
      vim.g.everforest_background = 'hard'
      init('everforest')
    end,
  },
}

return M
