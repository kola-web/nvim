local M = {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'moon' },
  },
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    'sainnhe/gruvbox-material',
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = {},
  },
  {
    'sainnhe/everforest',
  },
  {
    'rebelot/kanagawa.nvim',
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false, -- Enable this to disable setting the background color
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'lazy' },
      on_colors = function(colors)
        -- colors.bg = '#00262F'
      end,
      on_highlights = function(hl, c)
        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
  },
  {
    'oxfist/night-owl.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'Tsuzat/NeoSolarized.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = false,
    },
  },
}

M.name = 'gruvbox-material'
-- M.name = 'NeoSolarized'
-- M.name = 'gruvbox'
-- M.name = 'tokyonight'
-- M.name = 'kanagawa-dragon'
-- M.name = 'solarized-osaka'
-- M.name = 'night-owl'

function M.config()
  local status_ok, theme = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
