local M = {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'storm' },
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
    'sainnhe/everforest',
  },
  {
    'svrana/neosolarized.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
  },
}

M.name = 'neosolarized'

function M.config()
  local status_ok, theme = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
  require('neosolarized').setup({
    comment_italics = true,
    background_set = true,
  })
end

return M
