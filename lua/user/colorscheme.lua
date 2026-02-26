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
  -- 主題色配置，只保留常用的几个
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = init('catppuccin'),
    opts = {
      flavour = 'mocha',
      default_integrations = false,
      auto_integrations = true,
    },
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    opts = {},
    init = init('gruvbox'),
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {},
    init = init('tokyonight'),
  },
  -- 其他主题按需加载
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
