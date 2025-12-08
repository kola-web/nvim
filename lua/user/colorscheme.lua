-- local colorscheme = 'catppuccin'
-- local colorscheme = 'gruvbox-material'
-- local colorscheme = 'tokyonight'
-- local colorscheme = 'kanagawa'
-- local colorscheme = 'everforest'
-- local colorscheme = 'solarized-osaka'
local colorscheme = 'monokai-pro'

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
      vim.g.gruvbox_material_background = 'hard'
      init('gruvbox-material')
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
  {
    'loctvl842/monokai-pro.nvim',
    lazy = true,
    opts = {
      override = function(c)
        local hp = require('monokai-pro.color_helper')
        local common_fg = hp.lighten(c.sideBar.foreground, 30)

        return {
          SnacksPickerDirectory = { fg = c.base.dimmed3 },
          SnacksPicker = { bg = c.editor.background, fg = common_fg },
          SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
          SnacksPickerTree = { fg = c.editorLineNumber.foreground },
          NonText = { fg = c.base.dimmed3 }, -- not sure if this should be broken into all hl groups importing NonText

          MiniFilesDirectory = { fg = c.editorLineNumber.foreground },
        }
      end,
    },
    init = init('monokai-pro'),
  },
}

return M
