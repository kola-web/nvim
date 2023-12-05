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
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false, -- Enable this to disable setting the background color
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'lazy' },
      on_colors = function(colors)
        colors.bg = '#00262F'
      end,
      on_highlights = function(hl, c) end,
    },
  },
  {
    'cpea2506/one_monokai.nvim',
    priority = 1000,
    config = true,
  },
}

-- M.name = 'gruvbox-material'
-- M.name = 'NeoSolarized'
-- M.name = 'gruvbox'
-- M.name = 'tokyonight'
-- M.name = 'kanagawa-dragon'
M.name = 'solarized-osaka'
-- M.name = 'night-owl'
-- M.name = 'one_monokai'

function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
